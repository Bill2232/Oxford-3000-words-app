import 'package:drift/drift.dart';

import 'connection_stub.dart'
    if (dart.library.io) 'connection_native.dart'
    if (dart.library.js_interop) 'connection_web.dart' as impl;

/// Platform-appropriate [QueryExecutor] for [AppDatabase]. Conditional
/// imports pick the native (mobile/desktop) or web implementation at
/// compile time so the rest of the app never has to know which one is
/// active.
QueryExecutor openConnection() => impl.openConnection();
