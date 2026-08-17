import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/sound_effects_controller.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';

class SoundEffectsSettingsScreen extends ConsumerWidget {
  const SoundEffectsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(soundEffectsControllerProvider);
    final notifier = ref.read(soundEffectsControllerProvider.notifier);

    return AppScaffold(
      title: 'Sound effects',
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Text(
              'Play a short sound for correct and incorrect answers, '
              'reaching your daily goal, and mastering a word.',
            ),
          ),
          SwitchListTile(
            title: const Text('Sound effects'),
            subtitle: const Text('Enable or disable all in-app sounds'),
            value: settings.enabled,
            onChanged: notifier.setEnabled,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Volume',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Slider(
                  value: settings.volume,
                  onChanged:
                      settings.enabled ? notifier.setVolume : null,
                  min: 0,
                  max: 1,
                  divisions: 10,
                  label: '${(settings.volume * 100).round()}%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
