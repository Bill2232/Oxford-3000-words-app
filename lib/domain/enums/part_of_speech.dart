/// Grammatical category of a headword, as used by the Oxford 3000 list.
enum PartOfSpeech {
  noun,
  verb,
  adjective,
  adverb,
  preposition,
  pronoun,
  conjunction,
  determiner,
  exclamation,
  number;

  String get label => switch (this) {
        PartOfSpeech.noun => 'noun',
        PartOfSpeech.verb => 'verb',
        PartOfSpeech.adjective => 'adjective',
        PartOfSpeech.adverb => 'adverb',
        PartOfSpeech.preposition => 'preposition',
        PartOfSpeech.pronoun => 'pronoun',
        PartOfSpeech.conjunction => 'conjunction',
        PartOfSpeech.determiner => 'determiner',
        PartOfSpeech.exclamation => 'exclamation',
        PartOfSpeech.number => 'number',
      };

  static PartOfSpeech fromLabel(String value) {
    return PartOfSpeech.values.firstWhere(
      (e) => e.label == value.toLowerCase().trim(),
      orElse: () => PartOfSpeech.noun,
    );
  }
}
