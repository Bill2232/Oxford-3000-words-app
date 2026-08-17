import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/tts_service.dart';
import '../theme/app_motion.dart';
import '../theme/app_shadows.dart';

/// A compact speaker icon that speaks [headword] aloud on tap. Used
/// anywhere a single word needs its own pronunciation affordance outside
/// the practice screen's larger dedicated play button (the word list, word
/// detail screen).
class WordPronounceButton extends ConsumerStatefulWidget {
  const WordPronounceButton({required this.headword, this.size = 38, super.key});

  final String headword;
  final double size;

  @override
  ConsumerState<WordPronounceButton> createState() =>
      _WordPronounceButtonState();
}

class _WordPronounceButtonState extends ConsumerState<WordPronounceButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: 'Pronounce "${widget.headword}"',
      child: Semantics(
        button: true,
        label: 'Pronounce ${widget.headword}',
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          onTap: () => ref.read(ttsServiceProvider).speak(widget.headword),
          child: AnimatedScale(
            scale: _pressed ? 0.9 : 1,
            duration: AppMotion.fast,
            curve: AppMotion.standard,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.14),
                shape: BoxShape.circle,
                boxShadow: _pressed ? AppShadows.soft(scheme.primary) : null,
              ),
              child: Icon(
                Icons.volume_up_rounded,
                color: scheme.primary,
                size: widget.size * 0.55,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
