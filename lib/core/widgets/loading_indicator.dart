import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Centered loading spinner for full-screen or section loading states. Pass
/// [message] when the screen has more than one thing that could be
/// loading, so it's clear to the user (and to screen readers) what's
/// happening.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        label: message ?? 'Loading',
        liveRegion: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(message!, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
