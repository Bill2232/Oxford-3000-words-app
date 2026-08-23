import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_button.dart';

typedef AppConfirmDialogResult = ({bool confirmed, bool dontShowAgain});

/// A themed yes/no confirmation dialog, optionally with a "don't show this
/// again" checkbox (pass [checkboxLabel] to show one). `confirmed` is
/// `true` only if the user tapped the confirm action — dismissing any
/// other way (back button, tapping outside, Cancel) resolves to `false`.
/// `dontShowAgain` reflects the checkbox's final state when dismissed,
/// regardless of [checkboxLabel] being set; callers that don't ask for a
/// checkbox can just ignore it.
Future<AppConfirmDialogResult> showAppConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool isDestructive = false,
  String? checkboxLabel,
}) async {
  final result = await showDialog<AppConfirmDialogResult>(
    context: context,
    builder: (context) => _AppConfirmDialogContent(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      isDestructive: isDestructive,
      checkboxLabel: checkboxLabel,
    ),
  );
  return result ?? (confirmed: false, dontShowAgain: false);
}

class _AppConfirmDialogContent extends StatefulWidget {
  const _AppConfirmDialogContent({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.isDestructive,
    required this.checkboxLabel,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final bool isDestructive;
  final String? checkboxLabel;

  @override
  State<_AppConfirmDialogContent> createState() => _AppConfirmDialogContentState();
}

class _AppConfirmDialogContentState extends State<_AppConfirmDialogContent> {
  bool _dontShowAgain = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.message),
          if (widget.checkboxLabel != null)
            CheckboxListTile(
              value: _dontShowAgain,
              onChanged: (value) => setState(() => _dontShowAgain = value ?? false),
              title: Text(widget.checkboxLabel!),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
        ],
      ),
      actions: [
        AppButton(
          label: 'Cancel',
          variant: AppButtonVariant.text,
          onPressed: () => Navigator.of(context)
              .pop((confirmed: false, dontShowAgain: _dontShowAgain)),
        ),
        AppButton(
          label: widget.confirmLabel,
          variant:
              widget.isDestructive ? AppButtonVariant.outlined : AppButtonVariant.gradient,
          onPressed: () => Navigator.of(context)
              .pop((confirmed: true, dontShowAgain: _dontShowAgain)),
        ),
      ],
    );
  }
}
