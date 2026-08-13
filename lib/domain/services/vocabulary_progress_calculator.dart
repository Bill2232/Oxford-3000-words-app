import '../entities/cefr_level_progress.dart';
import '../entities/user_word_progress.dart';
import '../entities/vocabulary_progress.dart';
import '../entities/weak_word.dart';
import '../entities/word.dart';
import '../enums/cefr_level.dart';
import '../enums/mastery_level.dart';
import 'user_stats_calculator.dart' show calculateStreakDays;

/// A word is surfaced as "weak" once it's been attempted at least this many
/// times and gotten wrong often enough to be worth extra review.
const _weakWordMinAttempts = 2;
const _weakWordMaxAccuracyPercent = 65;
const _weakWordLimit = 10;

/// Pure aggregation of [UserWordProgress] rows (plus the full word list, for
/// CEFR grouping and headword lookups) into a [VocabularyProgress]. Kept as
/// a plain function so it's trivially testable and has no Riverpod/repo
/// dependency.
VocabularyProgress calculateVocabularyProgress({
  required List<Word> words,
  required List<UserWordProgress> progress,
  DateTime? now,
}) {
  final progressByWordId = {for (final p in progress) p.wordId: p};

  final totalAttempts = progress.fold<int>(0, (sum, p) => sum + p.timesReviewed);
  final correctAnswers = progress.fold<int>(0, (sum, p) => sum + p.timesCorrect);
  final incorrectAnswers = progress.fold<int>(0, (sum, p) => sum + p.timesIncorrect);
  final firstTryAttempted = progress.where((p) => p.timesReviewed > 0).length;
  final firstTrySuccesses =
      progress.fold<int>(0, (sum, p) => sum + p.firstAttemptSuccesses);
  final wordsMastered =
      progress.where((p) => p.masteryLevel == MasteryLevel.mastered).length;

  return VocabularyProgress(
    totalWords: words.length,
    wordsPracticed: progress.length,
    totalAttempts: totalAttempts,
    correctAnswers: correctAnswers,
    incorrectAnswers: incorrectAnswers,
    firstTryAccuracyPercent: firstTryAttempted == 0
        ? null
        : ((firstTrySuccesses / firstTryAttempted) * 100).round(),
    overallAccuracyPercent:
        totalAttempts == 0 ? null : ((correctAnswers / totalAttempts) * 100).round(),
    currentStreakDays: calculateStreakDays(progress, now: now),
    wordsMastered: wordsMastered,
    levelBreakdown: _levelBreakdown(words, progressByWordId),
    weakWords: _weakWords(words, progress),
  );
}

List<CefrLevelProgress> _levelBreakdown(
  List<Word> words,
  Map<int, UserWordProgress> progressByWordId,
) {
  return CefrLevel.values.map((level) {
    final wordsAtLevel = words.where((w) => w.cefrLevel == level).toList();
    final progressAtLevel = wordsAtLevel
        .map((w) => progressByWordId[w.id])
        .whereType<UserWordProgress>()
        .toList();

    final attempts = progressAtLevel.fold<int>(0, (sum, p) => sum + p.timesReviewed);
    final correct = progressAtLevel.fold<int>(0, (sum, p) => sum + p.timesCorrect);

    return CefrLevelProgress(
      level: level,
      totalWords: wordsAtLevel.length,
      practicedWords: progressAtLevel.length,
      masteredWords: progressAtLevel
          .where((p) => p.masteryLevel == MasteryLevel.mastered)
          .length,
      accuracyPercent:
          attempts == 0 ? null : ((correct / attempts) * 100).round(),
    );
  }).where((level) => level.totalWords > 0).toList();
}

List<WeakWord> _weakWords(List<Word> words, List<UserWordProgress> progress) {
  final wordsById = {for (final w in words) w.id: w};

  final candidates = progress.where((p) {
    if (p.timesReviewed < _weakWordMinAttempts) return false;
    return p.accuracyPercent <= _weakWordMaxAccuracyPercent;
  }).toList()
    ..sort((a, b) {
      final byIncorrect = b.timesIncorrect.compareTo(a.timesIncorrect);
      if (byIncorrect != 0) return byIncorrect;
      return a.accuracyPercent.compareTo(b.accuracyPercent);
    });

  return candidates
      .take(_weakWordLimit)
      .map((p) {
        final word = wordsById[p.wordId];
        if (word == null) return null;
        return WeakWord(
          word: word,
          timesReviewed: p.timesReviewed,
          timesIncorrect: p.timesIncorrect,
          accuracyPercent: p.accuracyPercent,
        );
      })
      .whereType<WeakWord>()
      .toList();
}
