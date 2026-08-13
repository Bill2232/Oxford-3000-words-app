import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// Speaks vocabulary words aloud via the platform's text-to-speech engine.
/// There are no bundled audio files — every word is spoken on demand, so
/// pronunciation works for the full list without shipping audio assets.
///
/// Every call is best-effort: a missing TTS engine, an unsupported voice,
/// or any other platform failure is swallowed here rather than thrown, so
/// a broken "Play" button never blocks the rest of the practice flow —
/// the user can still type and check their answer without ever hearing it.
class TtsService {
  TtsService() : _tts = FlutterTts() {
    _tts.setLanguage('en-US');
    _tts.setSpeechRate(0.42);
    _tts.setPitch(1.0);
  }

  final FlutterTts _tts;

  Future<void> speak(String text) async {
    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (error, stackTrace) {
      debugPrint('TtsService.speak failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (_) {
      // Best-effort — nothing meaningful to recover from here.
    }
  }

  void dispose() {
    unawaited(stop());
  }
}

final ttsServiceProvider = Provider<TtsService>((ref) {
  final service = TtsService();
  ref.onDispose(service.dispose);
  return service;
});
