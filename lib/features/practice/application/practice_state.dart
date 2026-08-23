import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/word.dart';
import 'check_result.dart';

part 'practice_state.freezed.dart';

/// State for a single practice session: the word currently being quizzed,
/// the outcome of the last check (if any), and lightweight session-only
/// counters. Nothing here is persisted — [wordsCompletedThisSession] resets
/// when the screen is left, unlike the real progress data in the DB.
@freezed
class PracticeState with _$PracticeState {
  const factory PracticeState({
    required Word word,
    @Default(CheckResult.none) CheckResult result,
    @Default(false) bool isRevealed,
    @Default(0) int attemptsThisWord,
    @Default(0) int wordsCompletedThisSession,
    @Default(false) bool justMarkedMastered,
  }) = _PracticeState;
}
