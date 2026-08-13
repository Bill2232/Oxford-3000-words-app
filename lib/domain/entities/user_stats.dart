import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';

/// Aggregate practice stats shown on the home screen. Entirely derived
/// from [UserWordProgress] rows plus the total word count — there's no
/// separate "stats" table, so this can never drift out of sync with the
/// underlying progress data.
@freezed
class UserStats with _$UserStats {
  const UserStats._();

  const factory UserStats({
    /// Distinct words with at least one review, ever.
    required int wordsPracticed,

    /// Total words in the current vocabulary list.
    required int totalWords,

    /// Overall correct-answer rate, 0-100. Null when nothing has been
    /// reviewed yet — there's no meaningful accuracy to show.
    required int? accuracyPercent,

    /// Consecutive days (including today, if already active) with at
    /// least one review.
    required int currentStreakDays,

    /// Distinct words reviewed today.
    required int todayPracticedCount,

    /// Today's target, from [AppConstants.dailyPracticeGoal].
    required int dailyGoal,

    /// Words at [MasteryLevel.mastered].
    required int masteredWords,
  }) = _UserStats;

  /// 0.0-1.0 fraction of today's goal completed.
  double get todayProgress =>
      dailyGoal <= 0 ? 0 : (todayPracticedCount / dailyGoal).clamp(0, 1);

  /// 0.0-1.0 fraction of the vocabulary list mastered.
  double get oxfordProgress =>
      totalWords <= 0 ? 0 : (masteredWords / totalWords).clamp(0, 1);

  bool get hasStreak => currentStreakDays > 0;
  bool get hasAccuracyData => accuracyPercent != null;
}
