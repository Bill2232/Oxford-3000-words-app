import 'package:shared_preferences/shared_preferences.dart';

/// Persists whether the "Mark as mastered?" confirmation dialog should be
/// skipped — set once the user checks "Don't ask me again".
class MarkAsMasteredPreferences {
  static const _skipConfirmationKey = 'skip_mark_as_mastered_confirmation';

  Future<bool> getSkipConfirmation() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_skipConfirmationKey) ?? false;
  }

  Future<void> setSkipConfirmation(bool skip) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_skipConfirmationKey, skip);
  }
}
