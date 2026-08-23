import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/practice/application/practice_controller.dart';
import '../../../providers/database_provider.dart';
import '../../../providers/mastered_progress_provider.dart';
import '../../../providers/user_stats_provider.dart';
import '../../../providers/vocabulary_progress_provider.dart';

/// Un-marks [wordId] as mastered, making it eligible for normal practice
/// again immediately. A single fire-and-forget mutation, not a state
/// machine, so this is a plain function rather than a dedicated
/// controller/notifier.
Future<void> removeFromMastered(WidgetRef ref, int wordId) async {
  final progressRepo = ref.read(progressRepositoryProvider);
  final existing = await progressRepo.getProgressForWord(wordId);
  if (existing == null || !existing.userMastered) return;

  await progressRepo.saveProgress(
    existing.copyWith(userMastered: false, masteredAt: null),
  );

  ref.invalidate(userStatsProvider);
  ref.invalidate(vocabularyProgressProvider);
  ref.invalidate(masteredProgressProvider);
  // A live practice session's word pool was built excluding this word;
  // invalidating makes it reappear next time practice is (re)entered
  // instead of only after the app restarts.
  ref.invalidate(practiceControllerProvider);
}
