import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Short UI sound effects the app can play, backed by procedurally
/// generated tones bundled under `assets/sounds/` (see that folder for the
/// exact asset paths — [AssetSource] paths are relative to `assets/`).
enum SoundEffect {
  correct('sounds/correct.wav'),
  incorrect('sounds/incorrect.wav'),
  dailyGoalReached('sounds/daily_goal.wav'),
  wordMastered('sounds/mastered.wav');

  const SoundEffect(this.assetPath);

  final String assetPath;
}

/// Plays short feedback sounds (correct/incorrect/daily goal/word mastered).
///
/// Every call is best-effort, mirroring the app's TTS service: a missing
/// audio backend or platform failure is swallowed here rather than thrown,
/// so a broken sound effect never blocks practice.
class SoundEffectsService {
  SoundEffectsService() : _player = AudioPlayer();

  final AudioPlayer _player;

  bool enabled = true;
  double volume = 0.8;

  Future<void> play(SoundEffect effect) async {
    if (!enabled || volume <= 0) return;
    try {
      await _player.stop();
      await _player.setVolume(volume);
      await _player.play(AssetSource(effect.assetPath));
    } catch (error, stackTrace) {
      debugPrint('SoundEffectsService.play failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void dispose() {
    unawaited(_player.dispose());
  }
}

final soundEffectsServiceProvider = Provider<SoundEffectsService>((ref) {
  final service = SoundEffectsService();
  ref.onDispose(service.dispose);
  return service;
});
