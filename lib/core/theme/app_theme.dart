import 'package:flutter/material.dart';

import 'app_palette.dart';
import 'app_semantic_colors.dart';
import 'app_spacing.dart';

/// Builds a complete [ThemeData] from an [AppPalette]. This is the only
/// place that turns palette colors into concrete widget theming, so every
/// screen/component styling change happens here, not in individual
/// widgets.
abstract final class AppTheme {
  static ThemeData from(AppPalette palette) {
    final colorScheme = _buildColorScheme(palette);

    return ThemeData(
      useMaterial3: true,
      brightness: palette.brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.background,
      splashFactory: InkSparkle.splashFactory,
      textTheme: _buildTextTheme(palette),
      dividerColor: palette.border,
      dividerTheme: DividerThemeData(color: palette.border, thickness: 1),
      iconTheme: IconThemeData(color: palette.textPrimary),
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: palette.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: palette.surfaceElevated,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: BorderSide(color: palette.border, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette.primary,
          foregroundColor: palette.onPrimary,
          disabledBackgroundColor: palette.primary.withValues(alpha: 0.4),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusPill)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.textPrimary,
          side: BorderSide(color: palette.border, width: 1.5),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusPill)),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: palette.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSpacing.radiusPill)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surfaceElevated,
        hintStyle: TextStyle(color: palette.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: palette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: palette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: palette.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: palette.primary,
        linearTrackColor: palette.surfaceElevated,
        circularTrackColor: palette.surfaceElevated,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: palette.textSecondary,
        textColor: palette.textPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: palette.surfaceElevated,
        labelStyle: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w600),
        side: BorderSide(color: palette.border),
        shape: const StadiumBorder(),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? palette.primary
              : palette.textSecondary,
        ),
      ),
      splashColor: palette.primary.withValues(alpha: 0.12),
      highlightColor: palette.primary.withValues(alpha: 0.06),
      extensions: [AppSemanticColors.from(palette)],
    );
  }

  static ColorScheme _buildColorScheme(AppPalette palette) {
    final base = ColorScheme.fromSeed(
      seedColor: palette.primary,
      brightness: palette.brightness,
    );

    return base.copyWith(
      primary: palette.primary,
      onPrimary: palette.onPrimary,
      secondary: palette.secondary,
      onSecondary: palette.onSecondary,
      surface: palette.surface,
      onSurface: palette.textPrimary,
      onSurfaceVariant: palette.textSecondary,
      outline: palette.border,
      outlineVariant: palette.border.withValues(alpha: 0.6),
      error: palette.error,
      onError: Colors.white,
      surfaceContainer: palette.surfaceElevated,
      surfaceContainerHigh: palette.surfaceElevated,
      surfaceContainerHighest: palette.surfaceElevated,
      surfaceContainerLow: palette.surface,
      surfaceContainerLowest: palette.background,
      scrim: Colors.black,
    );
  }

  static TextTheme _buildTextTheme(AppPalette palette) {
    TextStyle style(double size, FontWeight weight, {Color? color}) {
      return TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color ?? palette.textPrimary,
        height: 1.3,
      );
    }

    return TextTheme(
      displayLarge: style(40, FontWeight.w800),
      headlineMedium: style(28, FontWeight.w800),
      titleLarge: style(22, FontWeight.w700),
      titleMedium: style(18, FontWeight.w700),
      titleSmall: style(15, FontWeight.w700),
      bodyLarge: style(16, FontWeight.w400),
      bodyMedium: style(14, FontWeight.w400, color: palette.textSecondary),
      bodySmall: style(12, FontWeight.w400, color: palette.textSecondary),
      labelLarge: style(14, FontWeight.w700),
      labelMedium: style(12, FontWeight.w700, color: palette.textSecondary),
    );
  }
}
