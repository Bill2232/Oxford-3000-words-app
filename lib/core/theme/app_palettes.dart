import 'package:flutter/material.dart';

import 'app_palette.dart';

/// The full catalog of themes users can pick from. Each is a coherent,
/// hand-picked palette rather than a variation on light/dark — adding a
/// new theme means adding one entry here and nothing else.
abstract final class AppPalettes {
  static const midnight = AppPalette(
    id: 'midnight',
    name: 'Midnight',
    description: 'Deep blue-violet, futuristic',
    brightness: Brightness.dark,
    background: Color(0xFF0B0F2B),
    surface: Color(0xFF131736),
    surfaceElevated: Color(0xFF1C2154),
    primary: Color(0xFF6C63FF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF00E5FF),
    onSecondary: Color(0xFF00232A),
    textPrimary: Color(0xFFF5F6FF),
    textSecondary: Color(0xFFA0A8D0),
    border: Color(0xFF2A2F5C),
    success: Color(0xFF4ADE80),
    error: Color(0xFFFF6B81),
    gradientColors: [Color(0xFF6C63FF), Color(0xFF00E5FF)],
  );

  static const sakura = AppPalette(
    id: 'sakura',
    name: 'Sakura',
    description: 'Soft pink-purple, playful',
    brightness: Brightness.light,
    background: Color(0xFFFFF5F8),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFFFEAF2),
    primary: Color(0xFFFF6FA5),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFB983FF),
    onSecondary: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF3A2233),
    textSecondary: Color(0xFF8A6E7D),
    border: Color(0xFFF4D3E0),
    success: Color(0xFF3FB68A),
    error: Color(0xFFE5484D),
    gradientColors: [Color(0xFFFF9AC1), Color(0xFFC79BFF)],
  );

  static const ocean = AppPalette(
    id: 'ocean',
    name: 'Ocean',
    description: 'Blue-cyan, clean and refreshing',
    brightness: Brightness.light,
    background: Color(0xFFF0FAFC),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFE3F6FA),
    primary: Color(0xFF0091D5),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF00C2D1),
    onSecondary: Color(0xFF00272A),
    textPrimary: Color(0xFF0B2530),
    textSecondary: Color(0xFF4D7480),
    border: Color(0xFFC7E9F1),
    success: Color(0xFF20A47F),
    error: Color(0xFFE5484D),
    gradientColors: [Color(0xFF0091D5), Color(0xFF00E0C6)],
  );

  static const forest = AppPalette(
    id: 'forest',
    name: 'Forest',
    description: 'Green, calm and natural',
    brightness: Brightness.light,
    background: Color(0xFFF3F7F0),
    surface: Color(0xFFFFFFFF),
    surfaceElevated: Color(0xFFE7F0E1),
    primary: Color(0xFF2E7D5B),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF8CB369),
    onSecondary: Color(0xFF17240F),
    textPrimary: Color(0xFF1E2E22),
    textSecondary: Color(0xFF5A6E5E),
    border: Color(0xFFD3E4CB),
    success: Color(0xFF2E7D5B),
    error: Color(0xFFC0453D),
    gradientColors: [Color(0xFF2E7D5B), Color(0xFFA8D08D)],
  );

  static const aurora = AppPalette(
    id: 'aurora',
    name: 'Aurora',
    description: 'Purple-indigo, magical and modern',
    brightness: Brightness.dark,
    background: Color(0xFF120E26),
    surface: Color(0xFF1B1440),
    surfaceElevated: Color(0xFF251C57),
    primary: Color(0xFF9D4EDD),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF5CE1E6),
    onSecondary: Color(0xFF00292B),
    textPrimary: Color(0xFFF3EBFF),
    textSecondary: Color(0xFFB9A9DE),
    border: Color(0xFF3A2E70),
    success: Color(0xFF4ADE80),
    error: Color(0xFFFF6B81),
    gradientColors: [Color(0xFF7B2FF7), Color(0xFF5CE1E6)],
  );

  static const obsidian = AppPalette(
    id: 'obsidian',
    name: 'Obsidian',
    description: 'Very dark, minimal, sophisticated',
    brightness: Brightness.dark,
    background: Color(0xFF0A0A0C),
    surface: Color(0xFF131316),
    surfaceElevated: Color(0xFF1C1C20),
    primary: Color(0xFFC9A96E),
    onPrimary: Color(0xFF1A1508),
    secondary: Color(0xFF8A8A93),
    onSecondary: Color(0xFF141416),
    textPrimary: Color(0xFFF2F2F4),
    textSecondary: Color(0xFF9A9AA2),
    border: Color(0xFF2A2A30),
    success: Color(0xFF4ADE80),
    error: Color(0xFFFF6B6B),
    gradientColors: [Color(0xFFC9A96E), Color(0xFF8A8A93)],
  );

  static const all = <AppPalette>[
    midnight,
    sakura,
    ocean,
    forest,
    aurora,
    obsidian,
  ];

  static const defaultPalette = midnight;

  static AppPalette byId(String id) {
    return all.firstWhere((p) => p.id == id, orElse: () => defaultPalette);
  }
}
