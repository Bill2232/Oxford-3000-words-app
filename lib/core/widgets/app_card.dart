import 'package:flutter/material.dart';

import '../theme/app_shadows.dart';
import '../theme/app_spacing.dart';

/// Standard content card. Wraps [Card] so padding/tap behavior stays
/// consistent everywhere a card is used.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.glow = false,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  /// Adds a soft, theme-tinted shadow. Reserve for a card that should draw
  /// the eye (e.g. a hero/featured card) — not the default for lists.
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );

    if (!glow) return card;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: AppShadows.soft(Theme.of(context).colorScheme.primary),
      ),
      child: card,
    );
  }
}
