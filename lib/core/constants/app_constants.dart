/// App-wide constant values that don't belong to a specific feature.
abstract final class AppConstants {
  static const String appName = 'Wordly';
  static const String databaseFileName = 'wordly.sqlite';
  static const String seedDataAssetPath = 'assets/data/oxford3000.json';

  /// Words-per-day target used to compute "today's progress". Chosen as a
  /// reasonable default; making this user-configurable is a future
  /// settings feature, not part of this foundation.
  static const int dailyPracticeGoal = 20;
}
