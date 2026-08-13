import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/preferences/theme_preferences.dart';
import 'app_palette.dart';
import 'app_palettes.dart';

final themePreferencesProvider = Provider((ref) => ThemePreferences());

/// Holds the id of the currently selected theme, persists changes, and
/// restores the saved choice on startup.
class ThemeController extends Notifier<String> {
  @override
  String build() {
    _restore();
    return AppPalettes.defaultPalette.id;
  }

  Future<void> _restore() async {
    try {
      final saved = await ref.read(themePreferencesProvider).getSelectedThemeId();
      if (saved != null) {
        state = saved;
      }
    } catch (_) {
      // Falls back to the default palette already set by build() — a
      // failure to read prefs shouldn't block the app from rendering.
    }
  }

  Future<void> select(String themeId) async {
    // Applied immediately regardless of whether persistence succeeds — a
    // save failure shouldn't stop the theme from switching for this
    // session, it just won't survive a restart.
    state = themeId;
    try {
      await ref.read(themePreferencesProvider).setSelectedThemeId(themeId);
    } catch (_) {
      // Ignored — see above.
    }
  }
}

final themeControllerProvider = NotifierProvider<ThemeController, String>(
  ThemeController.new,
);

/// The resolved [AppPalette] for the currently selected theme id.
final selectedPaletteProvider = Provider<AppPalette>((ref) {
  final id = ref.watch(themeControllerProvider);
  return AppPalettes.byId(id);
});
