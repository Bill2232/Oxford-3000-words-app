/// Common European Framework of Reference level, as assigned to each
/// Oxford 3000 headword.
enum CefrLevel {
  a1,
  a2,
  b1,
  b2,
  c1;

  String get label => name.toUpperCase();

  static CefrLevel fromLabel(String value) {
    return CefrLevel.values.firstWhere(
      (e) => e.label == value.toUpperCase().trim(),
      orElse: () => CefrLevel.a1,
    );
  }
}
