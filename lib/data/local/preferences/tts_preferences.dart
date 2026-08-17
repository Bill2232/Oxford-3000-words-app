import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/tts_service.dart';

/// Persists the selected pronunciation accent locally.
class TtsPreferences {
  static const _accentKey = 'pronunciation_accent';

  Future<TtsAccent?> getSelectedAccent() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_accentKey);
    for (final accent in TtsAccent.values) {
      if (accent.name == stored) return accent;
    }
    return null;
  }

  Future<void> setSelectedAccent(TtsAccent accent) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accentKey, accent.name);
  }
}
