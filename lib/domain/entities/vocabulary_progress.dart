import 'package:freezed_annotation/freezed_annotation.dart';

import 'cefr_level_progress.dart';
import 'weak_word.dart';

part 'vocabulary_progress.freezed.dart';

/// Full aggregate backing the Statistics/Progress screen. Entirely derived
/// from [UserWordProgress] rows (plus the word list for CEFR grouping and
/// weak-word lookups) — there's no separate stats table, so this can never
/// drift out of sync with the underlying progress data.
///
/// This is vocabulary practice progress within this app's Oxford 3000
/// list — not an official CEFR language assessment.
@freezed
class VocabularyProgress with _$VocabularyProgress {
  const VocabularyProgress._();

  const factory VocabularyProgress({
    required int totalWords,
    required int wordsPracticed,
    required int totalAttempts,
    required int correctAnswers,
    required int incorrectAnswers,

    /// 0-100. Null when no word has ever had a first attempt recorded.
    required int? firstTryAccuracyPercent,

    /// 0-100. Null when nothing has been reviewed yet.
    required int? overallAccuracyPercent,
    required int currentStreakDays,
    required int wordsMastered,
    required List<CefrLevelProgress> levelBreakdown,
    required List<WeakWord> weakWords,
  }) = _VocabularyProgress;

  bool get hasAnyPractice => wordsPracticed > 0;
}
