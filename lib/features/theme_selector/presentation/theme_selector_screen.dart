import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_motion.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/theme/app_palettes.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/app_scaffold.dart';

class ThemeSelectorScreen extends ConsumerWidget {
  const ThemeSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(themeControllerProvider);

    return AppScaffold(
      title: 'App theme',
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 0.82,
        ),
        itemCount: AppPalettes.all.length,
        itemBuilder: (context, index) {
          final palette = AppPalettes.all[index];
          return _ThemePreviewCard(
            palette: palette,
            selected: palette.id == selectedId,
            onTap: () => ref.read(themeControllerProvider.notifier).select(palette.id),
          );
        },
      ),
    );
  }
}

class _ThemePreviewCard extends StatelessWidget {
  const _ThemePreviewCard({
    required this.palette,
    required this.selected,
    required this.onTap,
  });

  final AppPalette palette;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final currentScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: AppMotion.medium,
      curve: AppMotion.standard,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: selected ? currentScheme.primary : Colors.transparent,
          width: 2,
        ),
        boxShadow: selected ? AppShadows.soft(currentScheme.primary) : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: palette.surface,
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _MiniPreview(palette: palette)),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        palette.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: palette.textPrimary,
                        ),
                      ),
                    ),
                    if (selected)
                      Icon(Icons.check_circle, size: 18, color: palette.primary),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  palette.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, color: palette.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A tiny mock UI (hero gradient + fake button/text lines) rendered in the
/// target palette's own colors, so the preview looks like the app would
/// actually look — not just a color swatch.
class _MiniPreview extends StatelessWidget {
  const _MiniPreview({required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: DecoratedBox(
        decoration: BoxDecoration(color: palette.background),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 28,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: palette.primaryGradient,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 8,
                width: 60,
                decoration: BoxDecoration(
                  color: palette.textPrimary.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 8,
                width: 90,
                decoration: BoxDecoration(
                  color: palette.textSecondary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _dot(palette.primary),
                  const SizedBox(width: 4),
                  _dot(palette.secondary),
                  const SizedBox(width: 4),
                  _dot(palette.surfaceElevated, bordered: true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot(Color color, {bool bordered = false}) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: bordered ? Border.all(color: palette.border) : null,
      ),
    );
  }
}
