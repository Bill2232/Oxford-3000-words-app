import 'package:drift/drift.dart';

import 'words_table.dart';

/// Per-user progress on a word. Deliberately minimal — future features
/// (spaced repetition scheduling, streaks) add columns here without
/// touching [Words].
class UserWordProgressTable extends Table {
  IntColumn get wordId =>
      integer().references(Words, #id, onDelete: KeyAction.cascade)();
  IntColumn get timesReviewed => integer().withDefault(const Constant(0))();
  IntColumn get timesCorrect => integer().withDefault(const Constant(0))();
  IntColumn get timesIncorrect => integer().withDefault(const Constant(0))();
  IntColumn get firstAttemptSuccesses =>
      integer().withDefault(const Constant(0))();
  IntColumn get revealCount => integer().withDefault(const Constant(0))();
  IntColumn get hintCount => integer().withDefault(const Constant(0))();
  RealColumn get masteryScore => real().withDefault(const Constant(0))();
  TextColumn get masteryLevel =>
      text().withDefault(const Constant('newWord'))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastReviewedAt => dateTime().nullable()();
  DateTimeColumn get nextReviewAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {wordId};
}
