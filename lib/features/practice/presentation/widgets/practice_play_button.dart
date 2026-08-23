import 'package:flutter/material.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_shadows.dart';

/// The large circular pronunciation button shared by the practice and
/// mastered-review screens. Driven by [onPlay] rather than reading a
/// controller directly, so either screen's own controller can supply it.
class PlayButton extends StatefulWidget {
  const PlayButton({required this.onPlay, this.size = 96, super.key});

  final VoidCallback onPlay;
  final double size;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: 'Play pronunciation',
      child: Semantics(
        button: true,
        label: 'Play pronunciation',
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) => setState(() => _pressed = false),
          onTapCancel: () => setState(() => _pressed = false),
          onTap: widget.onPlay,
          child: AnimatedScale(
            scale: _pressed ? 0.94 : 1,
            duration: AppMotion.fast,
            curve: AppMotion.standard,
            child: AnimatedContainer(
              duration: AppMotion.medium,
              curve: AppMotion.standard,
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [scheme.primary, scheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: AppShadows.glow(scheme.primary),
              ),
              child: Icon(
                Icons.volume_up_rounded,
                color: Colors.white,
                size: widget.size * 0.42,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
