import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/word.dart';
import '../../practice/application/check_result.dart';

part 'mastered_review_state.freezed.dart';

/// State for a single mastered-word review session: a fixed queue of
/// words snapshotted at session start, the outcome of the last check, and
/// running session tallies. Nothing here is persisted — only the
/// per-attempt DB writes the controller makes along the way are durable,
/// same split as normal practice.
@freezed
class MasteredReviewState with _$MasteredReviewState {
  const MasteredReviewState._();

  const factory MasteredReviewState({
    required List<Word> queue,
    required int totalWordsAtStart,
    @Default(CheckResult.none) CheckResult result,
    @Default(0) int failuresThisWord,
    @Default(false) bool justAutoRemoved,
    @Default(0) int reviewedCount,
    @Default(0) int successCount,
    @Default(0) int keptDespiteMissCount,
    @Default(0) int returnedToPracticeCount,
    @Default(0) int totalMistakes,
    @Default(false) bool isComplete,
  }) = _MasteredReviewState;

  Word? get currentWord => queue.isEmpty ? null : queue.first;

  int get currentPosition => reviewedCount + 1;
}
