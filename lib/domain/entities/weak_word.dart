import 'package:freezed_annotation/freezed_annotation.dart';

import 'word.dart';

part 'weak_word.freezed.dart';

/// A practiced word the user frequently gets wrong, surfaced on the
/// statistics screen so they know what to focus on next.
@freezed
class WeakWord with _$WeakWord {
  const WeakWord._();

  const factory WeakWord({
    required Word word,
    required int timesReviewed,
    required int timesIncorrect,
    required int accuracyPercent,
  }) = _WeakWord;
}
