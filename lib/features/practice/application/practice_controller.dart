import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/sound_effects_service.dart';
import '../../../core/services/tts_service.dart';
import '../../../data/local/preferences/mark_as_mastered_preferences.dart';
import '../../../domain/entities/user_word_progress.dart';
import '../../../domain/entities/word.dart';
import '../../../domain/enums/mastery_level.dart';
import '../../../domain/services/mastery_progression.dart';
import '../../../providers/database_provider.dart';
import '../../../providers/mastered_progress_provider.dart';
import '../../../providers/user_stats_provider.dart';
import '../../../providers/vocabulary_progress_provider.dart';
import 'check_result.dart';
import 'practice_state.dart';

final markAsMasteredPreferencesProvider =
    Provider((ref) => MarkAsMasteredPreferences());

/// Drives a single practice session: picks a random word, plays its
/// pronunciation, checks typed answers, and records each attempt against
/// the real progress table. No spaced repetition — word order is just
/// "don't repeat the immediately previous word". Words the user has
/// explicitly marked as mastered are excluded from the pool entirely —
/// see the "Mastered Words" feature, which reviews them separately.
class PracticeController extends AsyncNotifier<PracticeState> {
  final _random = Random();
  List<Word> _pool = [];

  @override
  Future<PracticeState> build() async {
    await ref.watch(seedProvider.future);
    final allWords = await ref.watch(wordRepositoryProvider).getAllWords();
    final allProgress = await ref.watch(progressRepositoryProvider).getAllProgress();
    final masteredIds = {
      for (final p in allProgress)
        if (p.userMastered) p.wordId,
    };
    _pool = allWords.where((w) => !masteredIds.contains(w.id)).toList();

    if (_pool.isEmpty) {
      throw StateError(
        allWords.isEmpty
            ? 'No vocabulary words are available to practice yet.'
            : "You've mastered every word! Review them from Mastered Words, "
                'or un-mark one to practice it again.',
      );
    }

    return PracticeState(word: _pickRandomWord(exclude: null));
  }

  /// Removes a word from the in-memory pool immediately (e.g. right after
  /// marking it mastered) so it can't be picked again for the rest of this
  /// session without waiting for the provider to rebuild.
  void excludeFromPool(int wordId) {
    _pool.removeWhere((w) => w.id == wordId);
  }

  Word _pickRandomWord({required Word? exclude}) {
    if (_pool.length == 1) return _pool.first;
    Word candidate;
    do {
      candidate = _pool[_random.nextInt(_pool.length)];
    } while (exclude != null && candidate.id == exclude.id);
    return candidate;
  }

  void playAudio() {
    final word = state.valueOrNull?.word;
    if (word != null) {
      ref.read(ttsServiceProvider).speak(word.headword);
    }
  }

  /// Clears the last (incorrect) result so the input reads as neutral
  /// again while the user edits their answer — no new attempt is recorded
  /// until they press Check again.
  void clearResult() {
    final current = state.valueOrNull;
    if (current == null || current.result == CheckResult.none) return;
    state = AsyncData(current.copyWith(result: CheckResult.none));
  }

  Future<bool> checkAnswer(String input) async {
    final current = state.valueOrNull;
    if (current == null) return false;

    final isCorrect =
        input.trim().toLowerCase() == current.word.headword.toLowerCase();

    // Spelling feedback is applied first and unconditionally — whether the
    // answer was right is already known, and the user should see that
    // immediately rather than have it depend on a database write
    // succeeding. Progress persistence follows as a best-effort side
    // effect (see `_recordAttemptSafely`).
    state = AsyncData(
      current.copyWith(
        result: isCorrect ? CheckResult.correct : CheckResult.incorrect,
        attemptsThisWord: current.attemptsThisWord + 1,
      ),
    );
    ref
        .read(soundEffectsServiceProvider)
        .play(isCorrect ? SoundEffect.correct : SoundEffect.incorrect);

    await _recordAttemptSafely(current.word, isCorrect: isCorrect);

    return isCorrect;
  }

  Future<void> revealAnswer() async {
    final current = state.valueOrNull;
    if (current == null || current.isRevealed) return;

    state = AsyncData(
      current.copyWith(
        isRevealed: true,
        result: CheckResult.incorrect,
        attemptsThisWord: current.attemptsThisWord + 1,
      ),
    );

    await _recordAttemptSafely(current.word, isCorrect: false, isReveal: true);
  }

  void nextWord() {
    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncData(
      PracticeState(
        word: _pickRandomWord(exclude: current.word),
        wordsCompletedThisSession: current.wordsCompletedThisSession + 1,
      ),
    );
  }

  /// Marks the current word as user-mastered: pulls it out of this (and
  /// every future) normal practice session and into "Mastered Words". A
  /// no-op if it's already mastered (shouldn't be reachable in practice,
  /// since a mastered word can't appear in this pool in the first place —
  /// guarded anyway so this is safe to call defensively).
  Future<void> markCurrentWordAsMastered() async {
    final current = state.valueOrNull;
    if (current == null) return;

    final progressRepo = ref.read(progressRepositoryProvider);
    final now = DateTime.now();
    final existing = await progressRepo.getProgressForWord(current.word.id);
    if (existing?.userMastered ?? false) return;

    final updated = (existing ?? newUserWordProgress(current.word.id, now))
        .copyWith(userMastered: true, masteredAt: now);
    await progressRepo.saveProgress(updated);

    excludeFromPool(current.word.id);
    state = AsyncData(current.copyWith(justMarkedMastered: true));

    ref.invalidate(userStatsProvider);
    ref.invalidate(vocabularyProgressProvider);
    ref.invalidate(masteredProgressProvider);
  }

  /// Undoes [markCurrentWordAsMastered] — for reversing an accidental tap.
  /// A no-op if the word isn't currently mastered.
  Future<void> unmarkCurrentWordAsMastered() async {
    final current = state.valueOrNull;
    if (current == null) return;

    final progressRepo = ref.read(progressRepositoryProvider);
    final existing = await progressRepo.getProgressForWord(current.word.id);
    if (!(existing?.userMastered ?? false)) return;

    await progressRepo.saveProgress(
      existing!.copyWith(userMastered: false, masteredAt: null),
    );

    if (!_pool.any((w) => w.id == current.word.id)) {
      _pool.add(current.word);
    }
    state = AsyncData(current.copyWith(justMarkedMastered: false));

    ref.invalidate(userStatsProvider);
    ref.invalidate(vocabularyProgressProvider);
    ref.invalidate(masteredProgressProvider);
  }

  /// Wraps [_recordAttempt] so a persistence failure (disk full, DB
  /// locked, etc.) is logged and swallowed rather than left unhandled —
  /// progress tracking is secondary to the practice loop itself, and by
  /// the time this runs the correctness feedback is already applied to
  /// [state], so a write failure here only means this one attempt won't
  /// be reflected in stats, not a broken practice session.
  Future<void> _recordAttemptSafely(
    Word word, {
    required bool isCorrect,
    bool isReveal = false,
  }) async {
    try {
      await _recordAttempt(word, isCorrect: isCorrect, isReveal: isReveal);
    } catch (error, stackTrace) {
      debugPrint('Failed to record practice attempt: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _recordAttempt(
    Word word, {
    required bool isCorrect,
    bool isReveal = false,
  }) async {
    final progressRepo = ref.read(progressRepositoryProvider);
    final now = DateTime.now();
    final existing = await progressRepo.getProgressForWord(word.id);
    final isVeryFirstAttempt = existing == null;

    final base = existing ?? newUserWordProgress(word.id, now);

    final newTimesCorrect = base.timesCorrect + (isCorrect ? 1 : 0);
    final newMasteryLevel = isCorrect
        ? nextMasteryLevelOnCorrect(
            current: base.masteryLevel,
            timesCorrectAfterThisAttempt: newTimesCorrect,
          )
        : base.masteryLevel;

    final updated = base.copyWith(
      timesReviewed: base.timesReviewed + 1,
      timesCorrect: newTimesCorrect,
      timesIncorrect: base.timesIncorrect + (isCorrect ? 0 : 1),
      firstAttemptSuccesses:
          base.firstAttemptSuccesses + (isVeryFirstAttempt && isCorrect ? 1 : 0),
      revealCount: base.revealCount + (isReveal ? 1 : 0),
      masteryScore: masteryScoreFor(newMasteryLevel),
      masteryLevel: newMasteryLevel,
      lastReviewedAt: now,
    );

    // Read today's progress *before* this attempt is saved so the daily-goal
    // sound can fire exactly on the crossing, not on every attempt after.
    final statsBefore = await ref.read(userStatsProvider.future);

    await progressRepo.saveProgress(updated);
    ref.invalidate(userStatsProvider);
    ref.invalidate(vocabularyProgressProvider);

    final soundEffects = ref.read(soundEffectsServiceProvider);
    if (newMasteryLevel == MasteryLevel.mastered &&
        base.masteryLevel != MasteryLevel.mastered) {
      soundEffects.play(SoundEffect.wordMastered);
    }

    final statsAfter = await ref.read(userStatsProvider.future);
    if (statsBefore.todayPracticedCount < statsAfter.dailyGoal &&
        statsAfter.todayPracticedCount >= statsAfter.dailyGoal) {
      soundEffects.play(SoundEffect.dailyGoalReached);
    }
  }
}

final practiceControllerProvider =
    AsyncNotifierProvider<PracticeController, PracticeState>(
  PracticeController.new,
);
