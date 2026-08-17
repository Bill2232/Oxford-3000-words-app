import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/tts_accent_controller.dart';
import '../../../../core/services/tts_service.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../application/practice_controller.dart';

/// Lets the user switch pronunciation accent without leaving practice —
/// tapping a side applies it immediately (via [ttsAccentControllerProvider],
/// which already persists it) and replays the current word so the switch is
/// audibly confirmed on the spot.
class AccentQuickSwitch extends ConsumerWidget {
  const AccentQuickSwitch({super.key});

  static const _flags = {
    TtsAccent.american: ('🇺🇸', 'US'),
    TtsAccent.british: ('🇬🇧', 'UK'),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(ttsAccentControllerProvider);

    return Semantics(
      container: true,
      label: 'Pronunciation accent, currently ${selected.label}',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final accent in TtsAccent.values) ...[
            if (accent != TtsAccent.values.first)
              const SizedBox(width: AppSpacing.sm),
            _AccentChip(
              accent: accent,
              selected: accent == selected,
              onTap: () => _select(ref, accent),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _select(WidgetRef ref, TtsAccent accent) async {
    if (ref.read(ttsAccentControllerProvider) == accent) return;
    await ref.read(ttsAccentControllerProvider.notifier).select(accent);
    ref.read(practiceControllerProvider.notifier).playAudio();
  }
}

class _AccentChip extends StatelessWidget {
  const _AccentChip({
    required this.accent,
    required this.selected,
    required this.onTap,
  });

  final TtsAccent accent;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (flag, code) = AccentQuickSwitch._flags[accent]!;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.medium,
        curve: AppMotion.standard,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: selected
              ? LinearGradient(
                  colors: [scheme.primary, scheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: selected ? null : scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          boxShadow: selected ? AppShadows.glow(scheme.primary) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flag, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: AppSpacing.xs),
            Text(
              code,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selected ? Colors.white : scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
