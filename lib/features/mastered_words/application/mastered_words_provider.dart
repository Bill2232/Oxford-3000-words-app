import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/database_provider.dart';
import '../../../providers/mastered_progress_provider.dart';
import 'mastered_word_entry.dart';

/// All user-mastered words, joined with their word data for display,
/// most recently mastered first.
final masteredWordsProvider = FutureProvider<List<MasteredWordEntry>>((ref) async {
  final progress = await ref.watch(masteredProgressProvider.future);
  final words = await ref.watch(wordRepositoryProvider).getAllWords();
  final wordsById = {for (final w in words) w.id: w};

  final entries = [
    for (final p in progress)
      if (wordsById[p.wordId] case final word?)
        MasteredWordEntry(
          word: word,
          automaticMasteryLevel: p.masteryLevel,
          masteredAt: p.masteredAt,
        ),
  ];

  entries.sort((a, b) {
    final aDate = a.masteredAt;
    final bDate = b.masteredAt;
    if (aDate == null && bDate == null) return 0;
    if (aDate == null) return 1;
    if (bDate == null) return -1;
    return bDate.compareTo(aDate);
  });

  return entries;
});
