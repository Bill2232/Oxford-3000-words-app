import 'package:flutter/material.dart';

/// Consistent animation timing/easing so motion feels like one system
/// instead of every widget picking its own duration.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);

  /// Theme/palette switch — slightly slower so the color cross-fade reads.
  static const Duration themeSwitch = Duration(milliseconds: 450);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeOutBack;
}
