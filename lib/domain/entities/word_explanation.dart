import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_explanation.freezed.dart';

/// AI-generated learning content for a word. Separate from [Word] itself —
/// [Word]'s fields (headword, definition, example) come from the bundled
/// dictionary data and are always available instantly; everything here is
/// generated on demand and can fail independently.
///
/// V1 fields only — see [ExplanationService] for what's deferred (memory
/// tricks, confusing-usage notes).
@freezed
class WordExplanation with _$WordExplanation {
  const factory WordExplanation({
    required String meaning,
    required List<String> commonUses,
    required String exampleSentence,
    required String shortStory,
  }) = _WordExplanation;
}
