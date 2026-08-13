import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_hero_action.dart';
import '../../../core/widgets/app_progress_bar.dart';
import '../../../core/widgets/app_reveal.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_stat_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../domain/entities/user_stats.dart';
import '../../../providers/user_stats_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(userStatsProvider);

    return AppScaffold(
      title: AppConstants.appName,
      padHorizontal: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.insights_outlined),
          tooltip: 'Vocabulary progress',
          onPressed: () => context.push(AppRoutes.statistics),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          tooltip: 'Settings',
          onPressed: () => context.push(AppRoutes.settings),
        ),
      ],
      body: statsAsync.when(
        loading: () => const LoadingIndicator(message: 'Loading your stats…'),
        error: (error, stackTrace) => EmptyState(
          icon: Icons.error_outline,
          message: 'Could not load your stats. Please try again.',
          onRetry: () => ref.invalidate(userStatsProvider),
        ),
        data: (stats) => _HomeContent(stats: stats),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ResponsiveCenter(
      builder: (context, isWide) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? AppSpacing.xl : AppSpacing.md,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppReveal(
                index: 0,
                child: _Greeting(theme: theme),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppReveal(
                index: 1,
                child: AppHeroAction(
                  title: 'Ready to practice?',
                  subtitle:
                      'Review today\'s words and keep your streak alive.',
                  actionLabel: 'Start Practice',
                  icon: Icons.bolt_rounded,
                  onTap: () => context.push(AppRoutes.practice),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppReveal(
                index: 2,
                child: _TodayProgressCard(stats: stats),
              ),
              const SizedBox(height: AppSpacing.lg),
              AppReveal(
                index: 3,
                child: _StatsGrid(stats: stats, isWide: isWide),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        );
      },
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_greeting(), style: theme.textTheme.bodyMedium),
          const SizedBox(height: 2),
          Text('Let\'s grow your vocabulary', style: theme.textTheme.headlineMedium),
        ],
      ),
    );
  }

  static String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }
}

class _TodayProgressCard extends StatelessWidget {
  const _TodayProgressCard({required this.stats});

  final UserStats stats;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percent = (stats.todayProgress * 100).round();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Today\'s Progress', style: theme.textTheme.titleMedium),
              Text('$percent%', style: theme.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          AppProgressBar(progress: stats.todayProgress),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${stats.todayPracticedCount} / ${stats.dailyGoal} words today',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(
                Icons.local_fire_department_rounded,
                size: 18,
                color: stats.hasStreak
                    ? context.semanticColors.streak
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Text(
                stats.hasStreak
                    ? '${stats.currentStreakDays} day streak'
                    : 'Start your streak today',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.stats, required this.isWide});

  final UserStats stats;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final cards = [
      AppStatCard(
        icon: Icons.check_circle_outline,
        value: '${stats.wordsPracticed}',
        label: 'Words practiced',
      ),
      AppStatCard(
        icon: Icons.track_changes_outlined,
        value: stats.hasAccuracyData ? '${stats.accuracyPercent}%' : '—',
        label: 'Accuracy',
      ),
      AppStatCard(
        icon: Icons.menu_book_outlined,
        value: '${stats.masteredWords} / ${stats.totalWords}',
        label: 'Oxford progress',
      ),
    ];

    return GridView.count(
      crossAxisCount: isWide ? 3 : (MediaQuery.sizeOf(context).width > 420 ? 3 : 2),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.15,
      children: cards,
    );
  }
}
