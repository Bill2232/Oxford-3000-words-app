import '../../domain/entities/word.dart';
import '../../domain/entities/word_explanation.dart';
import '../utils/result.dart';

/// Generates learner-facing explanations for a word (meaning, common uses,
/// an example sentence, a short story). The UI depends on this interface,
/// never on a specific AI provider — swapping providers means writing a
/// new implementation, not touching any screen.
///
/// V1 covers exactly: meaning, common uses, example sentence, short story.
/// Future implementations may add memory tricks and confusing-usage notes
/// without changing this contract (additive fields on [WordExplanation],
/// or a v2 interface) — not part of this version.
abstract interface class ExplanationService {
  Future<Result<WordExplanation>> explain(Word word);
}
