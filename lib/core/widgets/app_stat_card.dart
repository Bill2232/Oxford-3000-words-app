import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'app_card.dart';

/// Compact icon + value + label card for dashboards/summaries. Value is a
/// string so callers can show "—" for not-yet-available data instead of a
/// fabricated number.
class AppStatCard extends StatelessWidget {
  const AppStatCard({
    required this.icon,
    required this.value,
    required this.label,
    this.accentColor,
    super.key,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = accentColor ?? theme.colorScheme.primary;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 17, color: color),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: theme.textTheme.titleLarge),
          const SizedBox(height: 2),
          Text(
            label,
            style: theme.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
