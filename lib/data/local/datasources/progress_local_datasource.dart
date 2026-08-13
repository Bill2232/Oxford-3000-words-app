import '../database/app_database.dart';
import '../database/tables/user_word_progress_table.dart';

/// Thin wrapper around Drift queries for [UserWordProgressTable].
class ProgressLocalDataSource {
  ProgressLocalDataSource(this._db);

  final AppDatabase _db;

  Future<List<UserWordProgressTableData>> getAllProgress() =>
      _db.select(_db.userWordProgressTable).get();

  Future<UserWordProgressTableData?> getProgressForWord(int wordId) =>
      (_db.select(_db.userWordProgressTable)
            ..where((p) => p.wordId.equals(wordId)))
          .getSingleOrNull();

  Future<void> upsert(UserWordProgressTableCompanion progress) {
    return _db.into(_db.userWordProgressTable).insertOnConflictUpdate(
          progress,
        );
  }
}
