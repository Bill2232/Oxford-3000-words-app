import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

import '../../../../core/constants/app_constants.dart';

/// Web uses drift's WASM backend (IndexedDB-backed). Requires
/// `sqlite3.wasm` to be served from `web/sqlite3.wasm` — see the `sqlite3`
/// package's WASM release assets.
QueryExecutor openConnection() {
  return DatabaseConnection.delayed(Future(() async {
    final db = await WasmDatabase.open(
      databaseName: AppConstants.databaseFileName,
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );
    return db.resolvedExecutor;
  }));
}
