import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/user_word_progress.dart';
import 'database_provider.dart';

/// Progress rows for words the user has explicitly marked as mastered —
/// the single source of truth both the Mastered Words screen and the
/// mastered-review session build on. Shared here (rather than under one
/// feature) so both invalidate the same provider after a mutation.
final masteredProgressProvider = FutureProvider<List<UserWordProgress>>((ref) async {
  await ref.watch(seedProvider.future);
  final all = await ref.watch(progressRepositoryProvider).getAllProgress();
  return all.where((p) => p.userMastered).toList();
});
