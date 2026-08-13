import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/cefr_level.dart';
import '../enums/part_of_speech.dart';

part 'word.freezed.dart';

/// A single vocabulary entry, storage-agnostic (no Drift/SQL types here).
@freezed
class Word with _$Word {
  const factory Word({
    required int id,
    required String headword,
    required PartOfSpeech partOfSpeech,
    required CefrLevel cefrLevel,
    required String definition,
    required String exampleSentence,
    String? phoneticSpelling,
    String? audioUrl,
    @Default(<String>[]) List<String> tags,
  }) = _Word;
}
