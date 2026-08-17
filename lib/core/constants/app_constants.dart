/// App-wide constant values that don't belong to a specific feature.
abstract final class AppConstants {
  static const String appName = 'Lexora';
  // Left as-is (not renamed to match the app) so existing installs keep
  // finding their local database — renaming this would make the app look
  // for a file that doesn't exist yet and silently start empty.
  static const String databaseFileName = 'wordly.sqlite';
  static const String seedDataAssetPath = 'assets/data/oxford3000.json';

  /// Words-per-day target used to compute "today's progress". Chosen as a
  /// reasonable default; making this user-configurable is a future
  /// settings feature, not part of this foundation.
  static const int dailyPracticeGoal = 20;
}
