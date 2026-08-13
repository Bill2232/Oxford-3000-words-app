import 'package:flutter/material.dart';

/// Soft, colored shadows so elevation reads as a glow tinted by the active
/// palette rather than a flat gray drop-shadow.
abstract final class AppShadows {
  static List<BoxShadow> soft(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> glow(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 20,
          spreadRadius: -2,
          offset: const Offset(0, 6),
        ),
      ];
}
