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
/// This is the single place platform-specific pronunciation quirks are
/// handled — screens only ever call [speak]/[setAccent]; they never touch
/// `flutter_tts` or voice data directly. `flutter_tts` already routes each
/// method to a native implementation per platform (Android/iOS/macOS use
/// the OS TTS engine, Windows uses SAPI, web uses the browser's Web Speech
/// API), so what varies platform-to-platform isn't *how* we ask for a
/// voice — it's *what voices actually exist* and *when their list becomes
/// available*. [setAccent] accounts for both.
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

  /// Whether the most recent [setAccent] call found and selected a voice
  /// whose locale exactly matches the requested accent. `false` means no
  /// such voice exists on this platform/device and a fallback English
  /// voice is being used instead — pronunciation still works, just not
  /// necessarily in the requested accent (e.g. a Windows machine with no
  /// British voice pack installed can't produce a UK accent no matter what
  /// software does). Exposed so callers can decide whether to surface
  /// that, rather than the app silently pretending the switch worked.
  bool lastAccentExactMatch = true;

  /// Switches the spoken locale and voice.
  ///
  /// Different platforms — and, on the web, different browsers — expose
  /// different installed voices, so this never assumes a voice for the
  /// requested locale exists. It ranks whatever [FlutterTts.getVoices]
  /// reports (exact locale match, then any voice in the same language,
  /// then whatever's left) and explicitly selects the best candidate via
  /// [FlutterTts.setVoice], rather than trusting [FlutterTts.setLanguage]
  /// alone — on Windows in particular, `setLanguage` silently leaves the
  /// previous voice active when no exact-locale voice is installed, which
  /// is exactly what made US and UK sound identical there.
  ///
  /// Among same-priority candidates, prefers a higher-quality voice: the
  /// default compact voice on most platforms collapses unstressed vowels
  /// aggressively, which is exactly what makes close pairs like "accept"
  /// /əkˈsept/ and "except" /ɪkˈsept/ come out sounding alike — they
  /// differ only in that first, unstressed vowel. The "network" /
  /// "enhanced" / "premium" / "neural" voices most platforms also ship
  /// pronounce that vowel far more distinctly.
  Future<void> setAccent(TtsAccent accent) async {
    _accent = accent;
    try {
      // Best-effort coarse switch first; _selectVoice's explicit setVoice
      // call below is what actually determines the final voice, so this
      // is safe to attempt even where it can't find an exact match.
      await _tts.setLanguage(accent.localeCode);
      await _selectVoice(accent);
    } catch (error, stackTrace) {
      debugPrint('TtsService.setAccent failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> _selectVoice(TtsAccent accent) async {
    final voices = await _voicesWithRetry();
    if (voices.isEmpty) {
      // No voice metadata available at all — unsupported platform, or a
      // device/browser that genuinely reports none. setLanguage above is
      // the best effort possible; nothing further to select.
      return;
    }

    final requestedLocale = _normalizeLocale(accent.localeCode);
    final requestedLanguage = requestedLocale.split('_').first;

    // Priority 1: exact requested locale (e.g. "en-US").
    var candidates =
        voices.where((v) => _normalizeLocale('${v['locale']}') == requestedLocale).toList();
    final exactMatch = candidates.isNotEmpty;

    // Priority 2/3: no exact region match — fall back to any voice in the
    // same language (e.g. any English voice if no British one exists).
    if (candidates.isEmpty) {
      candidates = voices
          .where((v) => _normalizeLocale('${v['locale']}').startsWith('${requestedLanguage}_'))
          .toList();
    }

    // Priority 4: still nothing — rather than leave a stale voice from a
    // previous accent selected, deterministically pick from whatever
    // exists at all.
    if (candidates.isEmpty) {
      candidates = voices;
    }

    lastAccentExactMatch = exactMatch;
    if (!exactMatch) {
      debugPrint(
        'TtsService: no exact "${accent.localeCode}" voice available on '
        'this platform — falling back to the closest available voice.',
      );
    }

    final highQuality = RegExp(
      r'network|enhanced|premium|neural',
      caseSensitive: false,
    );
    final preferred = candidates.firstWhere(
      (voice) => highQuality.hasMatch('${voice['name']}'),
      orElse: () => candidates.first,
    );

    try {
      await _tts.setVoice({
        'name': '${preferred['name']}',
        'locale': '${preferred['locale']}',
      });
    } catch (error, stackTrace) {
      debugPrint('TtsService: setVoice failed for ${preferred['name']}: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  String _normalizeLocale(String locale) => locale.replaceAll('-', '_').toLowerCase();

  /// Web browsers report an empty voice list on the very first call after
  /// page load — `speechSynthesis.getVoices()` populates asynchronously
  /// (browsers fire a `voiceschanged` event once it's ready, which
  /// `flutter_tts` doesn't expose to Dart), so a single immediate
  /// `getVoices` call can race that and come back empty even though
  /// voices are about to be available. Polling briefly avoids treating
  /// that startup race as "no voices exist" — on every other platform
  /// (and on a warm web page) this returns on the very first attempt.
  Future<List<Map>> _voicesWithRetry() async {
    for (var attempt = 0; attempt < 8; attempt++) {
      final voices = await _tts.getVoices;
      if (voices is List && voices.isNotEmpty) {
        return voices.whereType<Map>().toList();
      }
      if (attempt < 7) {
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }
    return const [];
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
