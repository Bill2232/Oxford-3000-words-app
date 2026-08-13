import 'package:shared_preferences/shared_preferences.dart';

/// Persists the selected theme id locally. A thin wrapper so the
/// controller doesn't depend on `shared_preferences` directly.
class ThemePreferences {
  static const _themeIdKey = 'selected_theme_id';

  Future<String?> getSelectedThemeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeIdKey);
  }

  Future<void> setSelectedThemeId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeIdKey, id);
  }
}
