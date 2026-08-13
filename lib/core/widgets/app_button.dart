import 'package:flutter/material.dart';

import '../theme/app_motion.dart';
import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';

enum AppButtonVariant { filled, gradient, outlined, text }

/// Single button component so styling changes happen in one place.
///
/// Every variant gets the same light press-scale feedback so the app's
/// buttons feel like one tactile system rather than some reacting to touch
/// and others not. [AppButtonVariant.gradient] additionally renders the
/// theme's signature gradient with a soft glow — reserved for primary,
/// high-emphasis actions (not every button, to avoid visual noise).
class AppButton extends StatefulWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.icon,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  bool get _interactive => widget.onPressed != null && !widget.isLoading;

  void _setPressed(bool value) {
    if (!_interactive) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final onPressedEffective = widget.isLoading ? null : widget.onPressed;
    final child = widget.isLoading
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: widget.variant == AppButtonVariant.gradient
                  ? Colors.white
                  : null,
            ),
          )
        : widget.icon == null
            ? Text(widget.label)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, size: 18),
                  const SizedBox(width: 8),
                  Text(widget.label),
                ],
              );

    final Widget button;
    if (widget.variant == AppButtonVariant.gradient) {
      final colorScheme = Theme.of(context).colorScheme;
      final gradient = LinearGradient(
        colors: [colorScheme.primary, colorScheme.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

      button = DecoratedBox(
        decoration: BoxDecoration(
          gradient: onPressedEffective == null ? null : gradient,
          color: onPressedEffective == null ? colorScheme.surfaceContainerHigh : null,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          boxShadow:
              onPressedEffective == null ? null : AppShadows.glow(colorScheme.primary),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressedEffective,
            borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: DefaultTextStyle.merge(
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
                child: IconTheme.merge(
                  data: const IconThemeData(color: Colors.white),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      button = switch (widget.variant) {
        AppButtonVariant.filled => ElevatedButton(
            onPressed: onPressedEffective,
            child: child,
          ),
        AppButtonVariant.outlined => OutlinedButton(
            onPressed: onPressedEffective,
            child: child,
          ),
        AppButtonVariant.text => TextButton(
            onPressed: onPressedEffective,
            child: child,
          ),
        AppButtonVariant.gradient => throw StateError('handled above'),
      };
    }

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: AppMotion.fast,
        curve: AppMotion.standard,
        child: button,
      ),
    );
  }
}
