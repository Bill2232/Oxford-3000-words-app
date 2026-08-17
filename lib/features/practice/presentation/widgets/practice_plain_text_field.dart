import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_semantic_colors.dart';
import '../../application/check_result.dart';

/// A standard, visibly-styled text field alternative to
/// [PracticeLetterInput] for entering a practice answer — same
/// [controller]/[focusNode] wiring, just without the letter-box chrome.
///
/// The whole point of this style is to give away nothing about the word —
/// unlike the boxed version, it deliberately does *not* cap input at (or
/// otherwise hint at) the word's length: no character counter, no
/// "N-letter word" hint text, and no silent input block once you hit N
/// characters that would let an attentive typist infer the length anyway.
/// [length] is still accepted (practice_screen.dart passes it uniformly to
/// both field styles) but intentionally unused here.
class PracticePlainTextField extends StatelessWidget {
  const PracticePlainTextField({
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
    final theme = Theme.of(context);

    final Color? borderColor;
    switch (result) {
      case CheckResult.correct:
        borderColor = context.semanticColors.success;
      case CheckResult.incorrect:
        borderColor = theme.colorScheme.error;
      case CheckResult.none:
        borderColor = null;
    }

    OutlineInputBorder? coloredBorder() {
      if (borderColor == null) return null;
      return OutlineInputBorder(borderSide: BorderSide(color: borderColor, width: 2));
    }

    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      autofocus: true,
      autocorrect: false,
      enableSuggestions: false,
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.done,
      style: theme.textTheme.headlineSmall,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
      ],
      decoration: InputDecoration(
        hintText: 'Type the word you hear',
        border: const OutlineInputBorder(),
        enabledBorder: coloredBorder(),
        focusedBorder: coloredBorder(),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
