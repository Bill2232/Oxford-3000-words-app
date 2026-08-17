import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../practice/application/answer_field_style.dart';
import '../../practice/application/answer_field_style_controller.dart';

class AnswerFieldSelectorScreen extends ConsumerWidget {
  const AnswerFieldSelectorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(answerFieldStyleControllerProvider);

    return AppScaffold(
      title: 'Answer field style',
      body: RadioGroup<AnswerFieldStyle>(
        groupValue: selected,
        onChanged: (value) {
          if (value != null) {
            ref.read(answerFieldStyleControllerProvider.notifier).select(value);
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
                'Choose how you type your answer during practice.',
              ),
            ),
            for (final style in AnswerFieldStyle.values)
              RadioListTile<AnswerFieldStyle>(
                value: style,
                title: Text(style.label),
                subtitle: Text(style.description),
              ),
          ],
        ),
      ),
    );
  }
}
