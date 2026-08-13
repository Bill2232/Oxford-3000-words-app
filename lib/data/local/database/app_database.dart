import 'package:drift/drift.dart';

import 'connection/connection.dart' as connection;
import 'tables/user_word_progress_table.dart';
import 'tables/words_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Words, UserWordProgressTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connection.openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(
              userWordProgressTable,
              userWordProgressTable.firstAttemptSuccesses,
            );
            await m.addColumn(
              userWordProgressTable,
              userWordProgressTable.revealCount,
            );
            await m.addColumn(
              userWordProgressTable,
              userWordProgressTable.hintCount,
            );
            await m.addColumn(
              userWordProgressTable,
              userWordProgressTable.masteryScore,
            );
          }
        },
      );
}
