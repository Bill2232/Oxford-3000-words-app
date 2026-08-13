import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/word.dart';
import '../../../providers/database_provider.dart';

/// All words, sourced from [wordRepositoryProvider]. Depends on
/// [seedProvider] so the list is never read before the DB has been
/// seeded on first run.
final wordListProvider = FutureProvider<List<Word>>((ref) async {
  await ref.watch(seedProvider.future);
  return ref.watch(wordRepositoryProvider).getAllWords();
});
