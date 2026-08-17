import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_semantic_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../application/check_result.dart';

/// Wordle-style letter boxes driven by a real (invisible) [TextField], so
/// physical keyboards, on-screen keyboards, and paste all work normally —
/// the boxes are just the visual layer on top. Box count reveals the
/// word's length (a length hint is normal for this kind of game) but never
/// its letters.
class PracticeLetterInput extends StatelessWidget {
  const PracticeLetterInput({
    required this.controller,
    required this.focusNode,
    required this.length,
    required this.result,
    required this.enabled,
    required this.onSubmitted,
    required this.onChanged,
    super.key,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final int length;
  final CheckResult result;
  final bool enabled;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => focusNode.requestFocus(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _BoxesRow(controller: controller, length: length, result: result),
          Positioned.fill(
            // `alwaysIncludeSemantics` matters here: a fully-transparent
            // subtree is excluded from the semantics tree by default, which
            // would make this field — the actual interactive control below
            // the decorative letter boxes — invisible to screen readers.
            child: Opacity(
              opacity: 0,
              alwaysIncludeSemantics: true,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                enabled: enabled,
                autofocus: true,
                autocorrect: false,
                enableSuggestions: false,
                textInputAction: TextInputAction.done,
                maxLength: length,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                ],
                buildCounter: (context,
                        {required currentLength, required isFocused, maxLength}) =>
                    null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Type the $length-letter word you hear',
                ),
                onChanged: onChanged,
                onSubmitted: onSubmitted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BoxesRow extends AnimatedWidget {
  const _BoxesRow({
    required this.controller,
    required this.length,
    required this.result,
  }) : super(listenable: controller);

  final TextEditingController controller;
  final int length;
  final CheckResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = controller.text;

    final Color borderColor;
    final Color? fillColor;
    switch (result) {
      case CheckResult.correct:
        final success = context.semanticColors.success;
        borderColor = success;
        fillColor = success.withValues(alpha: 0.12);
      case CheckResult.incorrect:
        borderColor = theme.colorScheme.error;
        fillColor = theme.colorScheme.error.withValues(alpha: 0.1);
      case CheckResult.none:
        borderColor = theme.colorScheme.outline;
        fillColor = theme.colorScheme.surfaceContainerHigh;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Shrink box size (and spacing) as the word gets longer so it stays
        // on one row wherever possible — a long word wrapping to a second
        // row is exactly what can push the Check button below the keyboard
        // on a phone screen.
        const maxBoxWidth = 40.0;
        const minBoxWidth = 24.0;
        const maxSpacing = 8.0;
        const minSpacing = 3.0;

        final fitWidth = length == 0
            ? maxBoxWidth
            : (constraints.maxWidth - (length - 1) * minSpacing) / length;
        final boxWidth = fitWidth.clamp(minBoxWidth, maxBoxWidth);
        final spacing = boxWidth < maxBoxWidth ? minSpacing : maxSpacing;
        final boxHeight = boxWidth < 32 ? boxWidth * 1.25 : 48.0;
        final fontSize = (boxWidth * 0.5).clamp(14.0, 22.0);

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: spacing,
          runSpacing: 8,
          children: List.generate(length, (i) {
            final char = i < text.length ? text[i].toUpperCase() : '';
            final isCursor = i == text.length && result == CheckResult.none;

            return AnimatedContainer(
              duration: AppMotion.fast,
              width: boxWidth,
              height: boxHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                border: Border.all(
                  color: isCursor ? theme.colorScheme.primary : borderColor,
                  width: isCursor ? 2 : 1.5,
                ),
              ),
              child: Text(
                char,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: fontSize,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
