import 'package:shared_preferences/shared_preferences.dart';

/// Persists the sound-effects on/off and volume settings locally.
class SoundEffectsPreferences {
  static const _enabledKey = 'sound_effects_enabled';
  static const _volumeKey = 'sound_effects_volume';

  Future<bool?> getEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enabledKey);
  }

  Future<void> setEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, enabled);
  }

  Future<double?> getVolume() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_volumeKey);
  }

  Future<void> setVolume(double volume) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_volumeKey, volume);
  }
}
