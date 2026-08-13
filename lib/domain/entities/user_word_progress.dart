import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/mastery_level.dart';

part 'user_word_progress.freezed.dart';

/// Tracks how a single user is doing on a single word. Kept minimal on
/// purpose — spaced-repetition scheduling, streaks, etc. can extend this
/// later without a rewrite since it's already a standalone entity keyed
/// by [wordId].
@freezed
class UserWordProgress with _$UserWordProgress {
  const UserWordProgress._();

  const factory UserWordProgress({
    required int wordId,
    required int timesReviewed,
    required int timesCorrect,
    required int timesIncorrect,
    required int firstAttemptSuccesses,
    required int revealCount,
    required int hintCount,
    required double masteryScore,
    required MasteryLevel masteryLevel,
    required DateTime createdAt,
    DateTime? lastReviewedAt,
    DateTime? nextReviewAt,
  }) = _UserWordProgress;

  /// Whether the very first attempt ever made on this word (across all
  /// sessions) was correct. Only meaningful once [timesReviewed] > 0.
  bool get firstAttemptWasSuccess => firstAttemptSuccesses > 0;

  int get accuracyPercent =>
      timesReviewed <= 0 ? 0 : ((timesCorrect / timesReviewed) * 100).round();
}
