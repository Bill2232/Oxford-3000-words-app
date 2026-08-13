import '../enums/mastery_level.dart';

/// Simple, deterministic mastery progression based on cumulative correct
/// answers. Intentionally not spaced repetition — just enough to make
/// "mastered" mean something until a real scheduling algorithm replaces
/// this.
///
/// A correct answer can only move mastery forward; an incorrect answer
/// never demotes it here (handled by the caller only incrementing counts).
MasteryLevel nextMasteryLevelOnCorrect({
  required MasteryLevel current,
  required int timesCorrectAfterThisAttempt,
}) {
  if (timesCorrectAfterThisAttempt >= 6) return MasteryLevel.mastered;
  if (timesCorrectAfterThisAttempt >= 3) {
    return _maxLevel(current, MasteryLevel.familiar);
  }
  if (timesCorrectAfterThisAttempt >= 1) {
    return _maxLevel(current, MasteryLevel.learning);
  }
  return current;
}

MasteryLevel _maxLevel(MasteryLevel a, MasteryLevel b) {
  return a.index >= b.index ? a : b;
}

/// Basic 0.0-1.0 mastery score derived from [MasteryLevel]. Deliberately
/// simple (evenly spaced by level) rather than a weighted recency/accuracy
/// formula — good enough to drive progress bars until spaced repetition
/// replaces this whole scheme.
double masteryScoreFor(MasteryLevel level) =>
    level.index / (MasteryLevel.values.length - 1);
