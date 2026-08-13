import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/vocabulary_progress.dart';
import '../domain/services/vocabulary_progress_calculator.dart';
import 'database_provider.dart';

/// Full statistics-screen aggregate, derived from the real progress table —
/// see [calculateVocabularyProgress]. Practice invalidates this after
/// recording an attempt (alongside [userStatsProvider]) so the Statistics
/// screen never shows stale numbers.
final vocabularyProgressProvider = FutureProvider<VocabularyProgress>((ref) async {
  await ref.watch(seedProvider.future);

  final words = await ref.watch(wordRepositoryProvider).getAllWords();
  final progress = await ref.watch(progressRepositoryProvider).getAllProgress();

  return calculateVocabularyProgress(words: words, progress: progress);
});
