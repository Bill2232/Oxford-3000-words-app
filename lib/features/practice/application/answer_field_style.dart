/// How the practice screen's answer input is presented.
enum AnswerFieldStyle {
  letterBoxes('Letter boxes', 'A Wordle-style box per letter'),
  plainText('Plain text field', 'A standard text field');

  const AnswerFieldStyle(this.label, this.description);

  final String label;
  final String description;
}
