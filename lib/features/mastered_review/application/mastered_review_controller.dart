import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/sound_effects_service.dart';
import '../../../core/services/tts_service.dart';
import '../../../domain/entities/user_word_progress.dart';
import '../../../providers/database_provider.dart';
import '../../../providers/mastered_progress_provider.dart';
import '../../../providers/user_stats_provider.dart';
import '../../../providers/vocabulary_progress_provider.dart';
import '../../practice/application/check_result.dart';
import '../../practice/application/practice_controller.dart';
import 'mastered_review_state.dart';

/// Drives a single mastered-word review session: a fixed snapshot of
/// currently-mastered words taken at session start, quizzed one at a
/// time. Fail the same word 3 times in this session and it's returned to
/// normal practice automatically; otherwise the user can retry, keep it
/// mastered despite a miss, or remove it themselves.
///
/// `autoDispose` (unlike [PracticeController]) so re-entering this screen
/// always re-snapshots the current mastered set rather than resuming a
/// stale or already-completed session.
class MasteredReviewController extends AutoDisposeAsyncNotifier<MasteredReviewState> {
  final _random = Random();

  @override
  Future<MasteredReviewState> build() async {
    await ref.watch(seedProvider.future);
    final masteredProgress = await ref.watch(masteredProgressProvider.future);
    final allWords = await ref.watch(wordRepositoryProvider).getAllWords();
    final wordsById = {for (final w in allWords) w.id: w};

    final queue = [
      for (final p in masteredProgress) ?wordsById[p.wordId],
    ]..shuffle(_random);

    if (queue.isEmpty) {
      throw StateError('No mastered words to review yet.');
    }

    return MasteredReviewState(queue: queue, totalWordsAtStart: queue.length);
  }

  void playAudio() {
    final word = state.valueOrNull?.currentWord;
    if (word != null) {
      ref.read(ttsServiceProvider).speak(word.headword);
    }
  }

  Future<bool> checkAnswer(String input) async {
    final current = state.valueOrNull;
    final word = current?.currentWord;
    if (current == null || word == null) return false;

    final isCorrect =
        input.trim().toLowerCase() == word.headword.toLowerCase();
    ref
        .read(soundEffectsServiceProvider)
        .play(isCorrect ? SoundEffect.correct : SoundEffect.incorrect);

    if (isCorrect) {
      await _recordReviewAttemptSafely(word.id, isCorrect: true);
      state = AsyncData(current.copyWith(result: CheckResult.correct));
      return true;
    }

    final newFailCount = current.failuresThisWord + 1;
    final autoRemove = newFailCount >= 3;
    await _recordReviewAttemptSafely(
      word.id,
      isCorrect: false,
      autoRemove: autoRemove,
    );
    state = AsyncData(
      current.copyWith(
        result: CheckResult.incorrect,
        failuresThisWord: newFailCount,
        justAutoRemoved: autoRemove,
        totalMistakes: current.totalMistakes + 1,
      ),
    );
    return false;
  }

  /// Mirrors [PracticeController.clearResult] — lets the user retype
  /// after a miss without it reading as a new attempt until Check again.
  void retry() {
    final current = state.valueOrNull;
    if (current == null || current.result == CheckResult.none) return;
    state = AsyncData(current.copyWith(result: CheckResult.none));
  }

  /// After a correct answer.
  void nextWord() {
    _advance((c) => c.copyWith(successCount: c.successCount + 1));
  }

  /// After a miss (not yet the 3rd): keep the word mastered and move on.
  void keepMastered() {
    _advance((c) => c.copyWith(keptDespiteMissCount: c.keptDespiteMissCount + 1));
  }

  /// After a miss (not yet the 3rd): the user gives up on this word
  /// themselves, same outcome as the automatic 3-strike removal.
  Future<void> removeFromMastered() async {
    final current = state.valueOrNull;
    final word = current?.currentWord;
    if (current == null || word == null) return;

    await _setUserMasteredSafely(word.id, false);
    _advance((c) => c.copyWith(returnedToPracticeCount: c.returnedToPracticeCount + 1));
  }

  /// After the 3rd-strike auto-removal banner — the DB write already
  /// happened inside [checkAnswer], this just moves the session forward.
  void continueAfterAutoRemoval() {
    _advance((c) => c.copyWith(returnedToPracticeCount: c.returnedToPracticeCount + 1));
  }

  void _advance(MasteredReviewState Function(MasteredReviewState) applyTally) {
    final current = state.valueOrNull;
    if (current == null) return;
    final tallied = applyTally(current);
    final remaining = tallied.queue.skip(1).toList();
    state = AsyncData(
      tallied.copyWith(
        queue: remaining,
        reviewedCount: tallied.reviewedCount + 1,
        result: CheckResult.none,
        failuresThisWord: 0,
        justAutoRemoved: false,
        isComplete: remaining.isEmpty,
      ),
    );
  }

  Future<void> _recordReviewAttemptSafely(
    int wordId, {
    required bool isCorrect,
    bool autoRemove = false,
  }) async {
    try {
      await _recordReviewAttempt(wordId, isCorrect: isCorrect, autoRemove: autoRemove);
    } catch (error, stackTrace) {
      debugPrint('Failed to record mastered-review attempt: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  /// Updates only the mastered-review lifetime counters (+ `userMastered`
  /// when [autoRemove]) — deliberately never touches
  /// timesReviewed/timesCorrect/timesIncorrect/masteryLevel/masteryScore,
  /// so reviewing a mastered word never distorts normal-practice stats
  /// (accuracy, streak, daily goal).
  Future<void> _recordReviewAttempt(
    int wordId, {
    required bool isCorrect,
    bool autoRemove = false,
  }) async {
    final progressRepo = ref.read(progressRepositoryProvider);
    final now = DateTime.now();
    final existing = await progressRepo.getProgressForWord(wordId);
    final base = existing ?? newUserWordProgress(wordId, now);

    var updated = base.copyWith(
      masteredReviewCount: base.masteredReviewCount + 1,
      masteredReviewSuccessCount:
          base.masteredReviewSuccessCount + (isCorrect ? 1 : 0),
      masteredReviewFailCount:
          base.masteredReviewFailCount + (isCorrect ? 0 : 1),
      lastMasteredReviewAt: now,
    );
    if (autoRemove) {
      updated = updated.copyWith(userMastered: false, masteredAt: null);
    }

    await progressRepo.saveProgress(updated);

    if (autoRemove) {
      ref.invalidate(userStatsProvider);
      ref.invalidate(vocabularyProgressProvider);
      ref.invalidate(masteredProgressProvider);
      ref.invalidate(practiceControllerProvider);
    }
  }

  Future<void> _setUserMasteredSafely(int wordId, bool mastered) async {
    try {
      final progressRepo = ref.read(progressRepositoryProvider);
      final existing = await progressRepo.getProgressForWord(wordId);
      if (existing == null || existing.userMastered == mastered) return;

      await progressRepo.saveProgress(
        existing.copyWith(
          userMastered: mastered,
          masteredAt: mastered ? DateTime.now() : null,
        ),
      );
      ref.invalidate(userStatsProvider);
      ref.invalidate(vocabularyProgressProvider);
      ref.invalidate(masteredProgressProvider);
      ref.invalidate(practiceControllerProvider);
    } catch (error, stackTrace) {
      debugPrint('Failed to update mastered status: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}

final masteredReviewControllerProvider = AsyncNotifierProvider.autoDispose<
    MasteredReviewController, MasteredReviewState>(MasteredReviewController.new);
