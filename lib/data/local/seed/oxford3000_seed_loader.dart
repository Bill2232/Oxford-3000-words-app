import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/word.dart';
import '../../../domain/enums/cefr_level.dart';
import '../../../domain/enums/part_of_speech.dart';
import '../database/mappers.dart';
import '../datasources/word_local_datasource.dart';

/// Populates [WordLocalDataSource] from the bundled JSON seed asset the
/// first time the app runs (i.e. whenever the words table is empty).
///
/// The bundled asset is a small placeholder subset today; swapping in the
/// full Oxford 3000 list later only means replacing the JSON asset, not
/// this loader.
class Oxford3000SeedLoader {
  Oxford3000SeedLoader(this._wordLocalDataSource);

  final WordLocalDataSource _wordLocalDataSource;

  Future<void> seedIfEmpty() async {
    final existing = await _wordLocalDataSource.count();
    if (existing > 0) return;

    final raw = await rootBundle.loadString(AppConstants.seedDataAssetPath);
    final entries = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();

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

    await _wordLocalDataSource.insertAll(words);
  }
}
