import '../../domain/entities/word.dart';
import '../local/database/mappers.dart';
import '../local/datasources/word_local_datasource.dart';

/// Public contract for reading vocabulary data. Screens/providers depend
/// on this abstraction, not on Drift, so a future remote/cloud-backed
/// implementation can be swapped in without touching callers.
abstract interface class WordRepository {
  Future<List<Word>> getAllWords();
  Future<Word?> getWordById(int id);
  Future<int> wordCount();
}

class WordRepositoryImpl implements WordRepository {
  WordRepositoryImpl(this._localDataSource);

  final WordLocalDataSource _localDataSource;

  @override
  Future<List<Word>> getAllWords() async {
    final rows = await _localDataSource.getAllWords();
    return rows.map((row) => row.toDomain()).toList();
  }

  @override
  Future<Word?> getWordById(int id) async {
    final row = await _localDataSource.getWordById(id);
    return row?.toDomain();
  }

  @override
  Future<int> wordCount() => _localDataSource.count();
}
