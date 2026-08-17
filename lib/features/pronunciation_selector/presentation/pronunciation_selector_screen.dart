import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/tts_accent_controller.dart';
import '../../../core/services/tts_service.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';

class PronunciationSelectorScreen extends ConsumerWidget {
  const PronunciationSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(ttsAccentControllerProvider);

    return AppScaffold(
      title: 'Pronunciation',
      body: RadioGroup<TtsAccent>(
        groupValue: selected,
        onChanged: (value) {
          if (value != null) {
            ref.read(ttsAccentControllerProvider.notifier).select(value);
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Text(
                'Choose the accent used when a word is played aloud during '
                'practice.',
              ),
            ),
            for (final accent in TtsAccent.values)
              RadioListTile<TtsAccent>(value: accent, title: Text(accent.label)),
          ],
        ),
      ),
    );
  }
}
