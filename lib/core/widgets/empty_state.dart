import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_button.dart';

/// Placeholder shown when a list/section has no content, or an error
/// occurred. Keeps that presentation consistent across features. Pass
/// [onRetry] for error states so the user has a way forward instead of a
/// dead end — every screen that can fail (a query, a seed load) should use
/// it rather than leaving the raw exception on screen with no action.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.action,
    this.onRetry,
    super.key,
  });

  final String message;
  final IconData icon;
  final Widget? action;

  /// When set, shows a "Retry" button that calls this instead of (or in
  /// addition to) [action].
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.colorScheme.outline),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: 'Retry',
                icon: Icons.refresh_rounded,
                variant: AppButtonVariant.outlined,
                onPressed: onRetry,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: AppSpacing.md),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
