import 'package:flutter/material.dart';

import 'app_palette.dart';

/// Semantic colors that aren't part of Flutter's [ColorScheme] but are used
/// consistently across the app (correct-answer green, streak flame). Kept
/// as a [ThemeExtension] so every screen reads the same palette-driven
/// values via `Theme.of(context)` instead of hardcoding a color literal —
/// the fix for a real bug where several screens hardcoded `0xFF22C55E`
/// instead of the palette's own [AppPalette.success].
@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  const AppSemanticColors({required this.success, required this.streak});

  final Color success;

  /// Used for the practice-streak flame. Not part of [AppPalette] since a
  /// warm flame color reads correctly against every palette; kept as one
  /// definition here rather than repeated literals at each call site.
  final Color streak;

  factory AppSemanticColors.from(AppPalette palette) {
    return AppSemanticColors(
      success: palette.success,
      streak: const Color(0xFFFF8A3D),
    );
  }

  @override
  AppSemanticColors copyWith({Color? success, Color? streak}) {
    return AppSemanticColors(
      success: success ?? this.success,
      streak: streak ?? this.streak,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      success: Color.lerp(success, other.success, t) ?? success,
      streak: Color.lerp(streak, other.streak, t) ?? streak,
    );
  }
}

extension AppSemanticColorsX on BuildContext {
  AppSemanticColors get semanticColors =>
      Theme.of(this).extension<AppSemanticColors>()!;
}
