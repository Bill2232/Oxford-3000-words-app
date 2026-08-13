import 'package:drift/drift.dart';

/// Vocabulary entries. Populated once from the bundled Oxford 3000 seed
/// asset; read-only from the app's perspective thereafter.
///
/// Named [WordRow] (via [DataClassName]) to avoid clashing with the
/// storage-agnostic domain entity `Word`.
@DataClassName('WordRow')
class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get headword => text().withLength(min: 1, max: 100)();
  TextColumn get partOfSpeech => text()();
  TextColumn get cefrLevel => text()();
  TextColumn get definition => text()();
  TextColumn get exampleSentence => text()();
  TextColumn get phoneticSpelling => text().nullable()();
  TextColumn get audioUrl => text().nullable()();

  /// Comma-separated tags; small enough not to warrant a join table yet.
  TextColumn get tags => text().withDefault(const Constant(''))();
}
