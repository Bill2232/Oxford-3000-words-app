import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/preferences/tts_preferences.dart';
import 'tts_service.dart';

final ttsPreferencesProvider = Provider((ref) => TtsPreferences());

/// Holds the selected pronunciation accent, persists changes, restores the
/// saved choice on startup, and keeps [TtsService] in sync so the next
/// `speak()` call uses it.
class TtsAccentController extends Notifier<TtsAccent> {
  @override
  TtsAccent build() {
    _restore();
    return TtsAccent.american;
  }

  Future<void> _restore() async {
    try {
      final saved = await ref.read(ttsPreferencesProvider).getSelectedAccent();
      if (saved != null) {
        state = saved;
        await ref.read(ttsServiceProvider).setAccent(saved);
      }
    } catch (_) {
      // Falls back to the default accent already set by build() — a
      // failure to read prefs shouldn't block the app from rendering.
    }
  }

  Future<void> select(TtsAccent accent) async {
    // Applied immediately regardless of whether persistence succeeds — a
    // save failure shouldn't stop the accent from switching for this
    // session, it just won't survive a restart.
    state = accent;
    await ref.read(ttsServiceProvider).setAccent(accent);
    try {
      await ref.read(ttsPreferencesProvider).setSelectedAccent(accent);
    } catch (_) {
      // Ignored — see above.
    }
  }
}

final ttsAccentControllerProvider =
    NotifierProvider<TtsAccentController, TtsAccent>(TtsAccentController.new);
