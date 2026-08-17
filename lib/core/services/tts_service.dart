import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// The pronunciation accents the app offers, backed by the BCP-47 locale
/// codes `flutter_tts` understands on every supported platform.
enum TtsAccent {
  american('en-US', 'American English'),
  british('en-GB', 'British English');

  const TtsAccent(this.localeCode, this.label);

  final String localeCode;
  final String label;
}

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
    _tts.setSpeechRate(0.45);
    _tts.setPitch(1.0);
    unawaited(setAccent(TtsAccent.american));
  }

  final FlutterTts _tts;
  TtsAccent _accent = TtsAccent.american;

  TtsAccent get accent => _accent;

  /// Switches the spoken locale and, where the platform offers more than
  /// one voice for it, prefers a higher-quality voice over the OS default.
  ///
  /// The default compact voice on most platforms collapses unstressed
  /// vowels aggressively, which is exactly what makes close pairs like
  /// "accept" /əkˈsept/ and "except" /ɪkˈsept/ come out sounding alike —
  /// they differ only in that first, unstressed vowel. The "network" /
  /// "enhanced" / "premium" voices most platforms also ship pronounce that
  /// vowel far more distinctly.
  Future<void> setAccent(TtsAccent accent) async {
    _accent = accent;
    try {
      await _tts.setLanguage(accent.localeCode);
      await _preferHighQualityVoice(accent);
    } catch (error, stackTrace) {
      debugPrint('TtsService.setAccent failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _preferHighQualityVoice(TtsAccent accent) async {
    final voices = await _tts.getVoices;
    if (voices is! List) return;

    final localePrefix = accent.localeCode.replaceAll('-', '_');
    final candidates = voices
        .whereType<Map>()
        .where(
          (voice) => '${voice['locale']}'
              .replaceAll('-', '_')
              .startsWith(localePrefix),
        )
        .toList();
    if (candidates.isEmpty) return;

    final highQuality = RegExp(
      r'network|enhanced|premium|neural',
      caseSensitive: false,
    );
    final preferred = candidates.firstWhere(
      (voice) => highQuality.hasMatch('${voice['name']}'),
      orElse: () => candidates.first,
    );

    await _tts.setVoice({
      'name': '${preferred['name']}',
      'locale': '${preferred['locale']}',
    });
  }

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
