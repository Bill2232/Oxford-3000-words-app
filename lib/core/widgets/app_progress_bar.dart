import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../theme/app_spacing.dart';

/// Rounded, animated linear progress bar. Animates from 0 to [progress]
/// whenever the value changes, so progress updates read as motion rather
/// than an instant jump.
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    required this.progress,
    this.color,
    this.trackColor,
    this.height = 10,
    super.key,
  });

  /// 0.0-1.0.
  final double progress;
  final Color? color;
  final Color? trackColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: progress.clamp(0, 1)),
        duration: AppMotion.slow,
        curve: AppMotion.standard,
        builder: (context, value, _) => LinearProgressIndicator(
          value: value,
          minHeight: height,
          backgroundColor: trackColor ?? scheme.surfaceContainerHighest,
          valueColor: AlwaysStoppedAnimation(color ?? scheme.primary),
        ),
      ),
    );
  }
}
