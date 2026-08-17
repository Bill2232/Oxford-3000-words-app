import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/preferences/sound_effects_preferences.dart';
import 'sound_effects_service.dart';

final soundEffectsPreferencesProvider =
    Provider((ref) => SoundEffectsPreferences());

/// Whether sound effects are enabled and how loud they play.
@immutable
class SoundEffectsSettings {
  const SoundEffectsSettings({required this.enabled, required this.volume});

  final bool enabled;
  final double volume;

  SoundEffectsSettings copyWith({bool? enabled, double? volume}) {
    return SoundEffectsSettings(
      enabled: enabled ?? this.enabled,
      volume: volume ?? this.volume,
    );
  }
}

/// Holds the sound-effects settings, persists changes, restores the saved
/// values on startup, and keeps [SoundEffectsService] in sync so the next
/// `play()` call uses them.
class SoundEffectsController extends Notifier<SoundEffectsSettings> {
  @override
  SoundEffectsSettings build() {
    _restore();
    return const SoundEffectsSettings(enabled: true, volume: 0.8);
  }

  Future<void> _restore() async {
    try {
      final prefs = ref.read(soundEffectsPreferencesProvider);
      final savedEnabled = await prefs.getEnabled();
      final savedVolume = await prefs.getVolume();
      if (savedEnabled == null && savedVolume == null) return;

      state = state.copyWith(enabled: savedEnabled, volume: savedVolume);
      final service = ref.read(soundEffectsServiceProvider);
      service.enabled = state.enabled;
      service.volume = state.volume;
    } catch (_) {
      // Falls back to the defaults already set by build() — a failure to
      // read prefs shouldn't block the app from rendering.
    }
  }

  Future<void> setEnabled(bool enabled) async {
    // Applied immediately regardless of whether persistence succeeds — a
    // save failure shouldn't stop the setting from taking effect for this
    // session, it just won't survive a restart.
    state = state.copyWith(enabled: enabled);
    ref.read(soundEffectsServiceProvider).enabled = enabled;
    try {
      await ref.read(soundEffectsPreferencesProvider).setEnabled(enabled);
    } catch (_) {
      // Ignored — see above.
    }
  }

  Future<void> setVolume(double volume) async {
    state = state.copyWith(volume: volume);
    ref.read(soundEffectsServiceProvider).volume = volume;
    try {
      await ref.read(soundEffectsPreferencesProvider).setVolume(volume);
    } catch (_) {
      // Ignored — see above.
    }
  }
}

final soundEffectsControllerProvider =
    NotifierProvider<SoundEffectsController, SoundEffectsSettings>(
  SoundEffectsController.new,
);
