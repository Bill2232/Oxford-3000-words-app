/// How well the user currently knows a word. Reserved for future
/// spaced-repetition scheduling; kept intentionally coarse for now.
enum MasteryLevel {
  newWord,
  learning,
  familiar,
  mastered;

  String get label => switch (this) {
        MasteryLevel.newWord => 'New',
        MasteryLevel.learning => 'Learning',
        MasteryLevel.familiar => 'Familiar',
        MasteryLevel.mastered => 'Mastered',
      };
}
