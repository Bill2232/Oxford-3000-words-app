import 'package:flutter_test/flutter_test.dart';
import 'package:oxford_3000_app/domain/entities/user_word_progress.dart';
import 'package:oxford_3000_app/domain/entities/word.dart';
import 'package:oxford_3000_app/domain/enums/cefr_level.dart';
import 'package:oxford_3000_app/domain/enums/mastery_level.dart';
import 'package:oxford_3000_app/domain/enums/part_of_speech.dart';
import 'package:oxford_3000_app/domain/services/vocabulary_progress_calculator.dart';

Word _word(int id, {CefrLevel level = CefrLevel.a1}) {
  return Word(
    id: id,
    headword: 'word$id',
    partOfSpeech: PartOfSpeech.noun,
    cefrLevel: level,
    definition: 'definition $id',
    exampleSentence: 'example $id',
  );
}

UserWordProgress _progress({
  required int wordId,
  required int timesReviewed,
  required int timesCorrect,
  required int timesIncorrect,
  int firstAttemptSuccesses = 0,
  int revealCount = 0,
  MasteryLevel masteryLevel = MasteryLevel.learning,
  DateTime? lastReviewedAt,
}) {
  return UserWordProgress(
    wordId: wordId,
    timesReviewed: timesReviewed,
    timesCorrect: timesCorrect,
    timesIncorrect: timesIncorrect,
    firstAttemptSuccesses: firstAttemptSuccesses,
    revealCount: revealCount,
    hintCount: 0,
    masteryScore: 0,
    masteryLevel: masteryLevel,
    createdAt: DateTime(2026, 1, 1),
    lastReviewedAt: lastReviewedAt,
  );
}

void main() {
  test('aggregates totals, accuracy, and mastery counts across all progress', () {
    final words = [
      _word(1, level: CefrLevel.a1),
      _word(2, level: CefrLevel.a1),
      _word(3, level: CefrLevel.b1),
    ];
    final progress = [
      _progress(
        wordId: 1,
        timesReviewed: 4,
        timesCorrect: 3,
        timesIncorrect: 1,
        firstAttemptSuccesses: 1,
        masteryLevel: MasteryLevel.mastered,
      ),
      _progress(
        wordId: 2,
        timesReviewed: 2,
        timesCorrect: 0,
        timesIncorrect: 2,
        firstAttemptSuccesses: 0,
      ),
    ];

    final result = calculateVocabularyProgress(words: words, progress: progress);

    expect(result.totalWords, 3);
    expect(result.wordsPracticed, 2);
    expect(result.totalAttempts, 6);
    expect(result.correctAnswers, 3);
    expect(result.incorrectAnswers, 3);
    expect(result.overallAccuracyPercent, 50);
    expect(result.firstTryAccuracyPercent, 50);
    expect(result.wordsMastered, 1);
  });

  test('accuracy fields are null when nothing has been practiced', () {
    final result = calculateVocabularyProgress(words: [_word(1)], progress: const []);

    expect(result.hasAnyPractice, isFalse);
    expect(result.overallAccuracyPercent, isNull);
    expect(result.firstTryAccuracyPercent, isNull);
  });

  test('groups progress by CEFR level and only includes levels with words', () {
    final words = [
      _word(1, level: CefrLevel.a1),
      _word(2, level: CefrLevel.b1),
    ];
    final progress = [
      _progress(wordId: 1, timesReviewed: 2, timesCorrect: 2, timesIncorrect: 0),
    ];

    final result = calculateVocabularyProgress(words: words, progress: progress);

    expect(result.levelBreakdown.map((l) => l.level), [CefrLevel.a1, CefrLevel.b1]);

    final a1 = result.levelBreakdown.firstWhere((l) => l.level == CefrLevel.a1);
    expect(a1.totalWords, 1);
    expect(a1.practicedWords, 1);
    expect(a1.accuracyPercent, 100);

    final b1 = result.levelBreakdown.firstWhere((l) => l.level == CefrLevel.b1);
    expect(b1.totalWords, 1);
    expect(b1.practicedWords, 0);
    expect(b1.accuracyPercent, isNull);
  });

  test('surfaces frequently-missed words as weak words, worst first', () {
    final words = [_word(1), _word(2), _word(3)];
    final progress = [
      // Well below the accuracy threshold with enough attempts: weak.
      _progress(wordId: 1, timesReviewed: 4, timesCorrect: 1, timesIncorrect: 3),
      // Only one attempt: not enough data yet, excluded regardless of miss.
      _progress(wordId: 2, timesReviewed: 1, timesCorrect: 0, timesIncorrect: 1),
      // High accuracy: not weak.
      _progress(wordId: 3, timesReviewed: 4, timesCorrect: 4, timesIncorrect: 0),
    ];

    final result = calculateVocabularyProgress(words: words, progress: progress);

    expect(result.weakWords, hasLength(1));
    expect(result.weakWords.single.word.id, 1);
    expect(result.weakWords.single.accuracyPercent, 25);
  });
}
