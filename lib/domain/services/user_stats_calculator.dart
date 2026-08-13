import '../entities/user_stats.dart';
import '../entities/user_word_progress.dart';
import '../enums/mastery_level.dart';

/// Pure aggregation of [UserWordProgress] rows into [UserStats]. Kept as a
/// plain function (not tied to Riverpod or a repository) so it's testable
/// in isolation and easy to reuse once the actual practice feature starts
/// writing progress rows.
UserStats calculateUserStats({
  required List<UserWordProgress> progress,
  required int totalWords,
  required int dailyGoal,
  DateTime? now,
}) {
  final today = _dateOnly(now ?? DateTime.now());

  final totalReviewed = progress.fold<int>(0, (sum, p) => sum + p.timesReviewed);
  final totalCorrect = progress.fold<int>(0, (sum, p) => sum + p.timesCorrect);

  final todayCount = progress
      .where((p) => p.lastReviewedAt != null && _dateOnly(p.lastReviewedAt!) == today)
      .length;

  final masteredWords =
      progress.where((p) => p.masteryLevel == MasteryLevel.mastered).length;

  return UserStats(
    wordsPracticed: progress.length,
    totalWords: totalWords,
    accuracyPercent:
        totalReviewed == 0 ? null : ((totalCorrect / totalReviewed) * 100).round(),
    currentStreakDays: calculateStreakDays(progress, now: now),
    todayPracticedCount: todayCount,
    dailyGoal: dailyGoal,
    masteredWords: masteredWords,
  );
}

/// Consecutive days (walking backwards from today) with at least one
/// reviewed word. If today has no activity yet but yesterday does, the
/// streak still counts as "active" — it isn't broken until a full day
/// passes with no practice.
int calculateStreakDays(List<UserWordProgress> progress, {DateTime? now}) {
  final today = _dateOnly(now ?? DateTime.now());
  final activeDays = <DateTime>{
    for (final p in progress)
      if (p.lastReviewedAt != null) _dateOnly(p.lastReviewedAt!),
  };
  if (activeDays.isEmpty) return 0;

  var cursor = today;
  if (!activeDays.contains(cursor)) {
    cursor = cursor.subtract(const Duration(days: 1));
    if (!activeDays.contains(cursor)) return 0;
  }

  var streak = 0;
  while (activeDays.contains(cursor)) {
    streak++;
    cursor = cursor.subtract(const Duration(days: 1));
  }
  return streak;
}

DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
