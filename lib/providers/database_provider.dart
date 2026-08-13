import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/database/app_database.dart';
import '../data/local/datasources/progress_local_datasource.dart';
import '../data/local/datasources/word_local_datasource.dart';
import '../data/local/seed/oxford3000_seed_loader.dart';
import '../data/repositories/progress_repository.dart';
import '../data/repositories/word_repository.dart';

/// Composition root: every dependent (repositories, datasources, the DB
/// itself) is wired here via Riverpod so features never construct their
/// own instances.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final wordLocalDataSourceProvider = Provider<WordLocalDataSource>((ref) {
  return WordLocalDataSource(ref.watch(appDatabaseProvider));
});

final progressLocalDataSourceProvider =
    Provider<ProgressLocalDataSource>((ref) {
  return ProgressLocalDataSource(ref.watch(appDatabaseProvider));
});

final wordRepositoryProvider = Provider<WordRepository>((ref) {
  return WordRepositoryImpl(ref.watch(wordLocalDataSourceProvider));
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return ProgressRepositoryImpl(ref.watch(progressLocalDataSourceProvider));
});

/// Seeds the local DB from the bundled Oxford 3000 subset on first run.
/// Screens await this (e.g. via `ref.watch(seedProvider)`) before reading
/// word data so the list is never empty on a fresh install.
final seedProvider = FutureProvider<void>((ref) async {
  final loader = Oxford3000SeedLoader(ref.watch(wordLocalDataSourceProvider));
  await loader.seedIfEmpty();
});
