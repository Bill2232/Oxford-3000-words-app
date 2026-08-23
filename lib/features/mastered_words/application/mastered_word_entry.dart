import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/word.dart';
import '../../../domain/enums/mastery_level.dart';

part 'mastered_word_entry.freezed.dart';

/// A user-mastered word joined with its display info for the Mastered
/// Words screen — [automaticMasteryLevel] is the app's own computed
/// assessment, shown alongside the user's own "I've got this" decision.
@freezed
class MasteredWordEntry with _$MasteredWordEntry {
  const factory MasteredWordEntry({
    required Word word,
    required MasteryLevel automaticMasteryLevel,
    DateTime? masteredAt,
  }) = _MasteredWordEntry;
}
