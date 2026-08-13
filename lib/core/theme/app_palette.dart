import 'package:flutter/material.dart';

/// A complete, self-contained color identity for the app. Unlike a
/// light/dark pair, each palette already bakes in its own [brightness] —
/// picking a theme is a single choice, not two.
@immutable
class AppPalette {
  const AppPalette({
    required this.id,
    required this.name,
    required this.description,
    required this.brightness,
    required this.background,
    required this.surface,
    required this.surfaceElevated,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.success,
    required this.error,
    required this.gradientColors,
  });

  final String id;
  final String name;
  final String description;
  final Brightness brightness;

  /// Page/scaffold background — usually a shade behind [surface].
  final Color background;

  /// Base surface for cards, sheets, and elevated content.
  final Color surface;

  /// A step brighter/darker than [surface], for nested or highlighted cards.
  final Color surfaceElevated;

  final Color primary;
  final Color onPrimary;

  /// Secondary/accent color used for highlights, links, and gradients.
  final Color secondary;
  final Color onSecondary;

  final Color textPrimary;
  final Color textSecondary;

  final Color border;

  final Color success;
  final Color error;

  /// Colors used to build this theme's signature gradient (hero sections,
  /// primary buttons, progress bars).
  final List<Color> gradientColors;

  LinearGradient get primaryGradient => LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
}
