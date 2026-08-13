import '../../domain/entities/user_word_progress.dart';
import '../local/database/mappers.dart';
import '../local/datasources/progress_local_datasource.dart';

/// Public contract for reading/writing per-user word progress.
abstract interface class ProgressRepository {
  Future<List<UserWordProgress>> getAllProgress();
  Future<UserWordProgress?> getProgressForWord(int wordId);
  Future<void> saveProgress(UserWordProgress progress);
}

class ProgressRepositoryImpl implements ProgressRepository {
  ProgressRepositoryImpl(this._localDataSource);

  final ProgressLocalDataSource _localDataSource;

  @override
  Future<List<UserWordProgress>> getAllProgress() async {
    final rows = await _localDataSource.getAllProgress();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<UserWordProgress?> getProgressForWord(int wordId) async {
    final row = await _localDataSource.getProgressForWord(wordId);
    return row?.toDomain();
  }

  @override
  Future<void> saveProgress(UserWordProgress progress) {
    return _localDataSource.upsert(progress.toCompanion());
  }
}
