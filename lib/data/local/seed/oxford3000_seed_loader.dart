import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/word.dart';
import '../../../domain/enums/cefr_level.dart';
import '../../../domain/enums/part_of_speech.dart';
import '../database/mappers.dart';
import '../datasources/progress_local_datasource.dart';
import '../datasources/word_local_datasource.dart';

/// Populates [WordLocalDataSource] from the bundled JSON seed asset.
///
/// Re-syncs (wipes and reinserts) whenever the seeded word count doesn't
/// match the bundled asset's count, rather than only seeding an empty
/// table — that's what lets a device that already seeded the old 20-word
/// placeholder list pick up the full Oxford 3000 list once it's bundled,
/// without a manual reinstall/data clear.
class Oxford3000SeedLoader {
  Oxford3000SeedLoader(this._wordLocalDataSource, this._progressLocalDataSource);

  final WordLocalDataSource _wordLocalDataSource;
  final ProgressLocalDataSource _progressLocalDataSource;

  Future<void> sync() async {
    final raw = await rootBundle.loadString(AppConstants.seedDataAssetPath);
    final entries = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();

    final existing = await _wordLocalDataSource.count();
    if (existing == entries.length) return;

    final words = entries.map((entry) {
      return Word(
        id: 0,
        headword: entry['headword'] as String,
        partOfSpeech: PartOfSpeech.fromLabel(entry['partOfSpeech'] as String),
        cefrLevel: CefrLevel.fromLabel(entry['cefrLevel'] as String),
        definition: entry['definition'] as String,
        exampleSentence: entry['exampleSentence'] as String,
        phoneticSpelling: entry['phoneticSpelling'] as String?,
        tags: (entry['tags'] as List?)?.cast<String>() ?? const [],
      ).toCompanion();
    }).toList();

    // A count mismatch can happen with progress rows already attached to
    // the old word set (e.g. this device's earlier 20-word placeholder
    // install) — clear progress before words so nothing is left pointing
    // at a row that's about to disappear.
    await _progressLocalDataSource.deleteAll();
    await _wordLocalDataSource.deleteAll();
    await _wordLocalDataSource.insertAll(words);
  }
}
