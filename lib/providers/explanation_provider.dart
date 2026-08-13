import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/services/anthropic_explanation_service.dart';
import '../core/services/explanation_service.dart';
import '../domain/entities/word.dart';
import '../domain/entities/word_explanation.dart';

final explanationServiceProvider = Provider<ExplanationService>((ref) {
  return AnthropicExplanationService();
});

/// Fetches an AI explanation for [word]. Bridges [ExplanationService]'s
/// [Result] to Riverpod's [AsyncValue] (throwing on failure) so the UI can
/// use the standard `.when(loading:, error:, data:)` — retry is just
/// `ref.invalidate(explanationContentProvider(word))`.
///
/// `autoDispose` matters here: this is a `.family` keyed by [Word], so
/// without it every distinct word the user ever asks to explain would stay
/// cached for the rest of the app's lifetime instead of being freed once
/// the explanation screen for that word is closed.
final explanationContentProvider =
    FutureProvider.autoDispose.family<WordExplanation, Word>((ref, word) async {
  final service = ref.watch(explanationServiceProvider);
  final result = await service.explain(word);
  return result.when(
    success: (value) => value,
    failure: (error, stackTrace) =>
        Error.throwWithStackTrace(error, stackTrace ?? StackTrace.current),
  );
});
