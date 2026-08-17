import 'package:drift/drift.dart';

import '../database/app_database.dart';
import '../database/tables/words_table.dart';

/// Thin wrapper around Drift queries for [Words]. Repositories depend on
/// this rather than touching `AppDatabase` directly, keeping SQL confined
/// to the data layer.
class WordLocalDataSource {
  WordLocalDataSource(this._db);

  final AppDatabase _db;

  Future<List<WordRow>> getAllWords() => _db.select(_db.words).get();

  Future<WordRow?> getWordById(int id) =>
      (_db.select(_db.words)..where((w) => w.id.equals(id)))
          .getSingleOrNull();

  Future<int> count() async {
    final query = _db.selectOnly(_db.words)
      ..addColumns([_db.words.id.count()]);
    final row = await query.getSingle();
    return row.read(_db.words.id.count()) ?? 0;
  }

  Future<void> insertAll(List<WordsCompanion> words) {
    return _db.batch((batch) => batch.insertAll(_db.words, words));
  }

  Future<void> deleteAll() => _db.delete(_db.words).go();
}
