import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import '../domain/entities/user_stats.dart';
import '../domain/services/user_stats_calculator.dart';
import 'database_provider.dart';

/// Aggregate practice stats shown on the home screen, derived from the
/// real progress table — see [calculateUserStats]. Shared across features
/// (home reads it; practice invalidates it after recording an attempt) so
/// it lives in the common providers directory rather than under a single
/// feature.
final userStatsProvider = FutureProvider<UserStats>((ref) async {
  await ref.watch(seedProvider.future);

  final progress = await ref.watch(progressRepositoryProvider).getAllProgress();
  final totalWords = await ref.watch(wordRepositoryProvider).wordCount();

  return calculateUserStats(
    progress: progress,
    totalWords: totalWords,
    dailyGoal: AppConstants.dailyPracticeGoal,
  );
});
