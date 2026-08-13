import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_semantic_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_progress_bar.dart';
import '../../../core/widgets/app_reveal.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/app_stat_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../domain/entities/cefr_level_progress.dart';
import '../../../domain/entities/vocabulary_progress.dart';
import '../../../domain/entities/weak_word.dart';
import '../../../providers/vocabulary_progress_provider.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressAsync = ref.watch(vocabularyProgressProvider);

    return AppScaffold(
      title: 'Vocabulary Progress',
      body: progressAsync.when(
        loading: () => const LoadingIndicator(message: 'Loading your progress…'),
        error: (error, stackTrace) => EmptyState(
          icon: Icons.error_outline,
          message: 'Could not load your progress. Please try again.',
          onRetry: () => ref.invalidate(vocabularyProgressProvider),
        ),
        data: (progress) => progress.hasAnyPractice
            ? _StatisticsContent(progress: progress)
            : const EmptyState(
                icon: Icons.insights_outlined,
                message:
                    'No practice yet. Complete a practice session to start '
                    'building your vocabulary progress.',
              ),
      ),
    );
  }
}

class _StatisticsContent extends StatelessWidget {
  const _StatisticsContent({required this.progress});

  final VocabularyProgress progress;

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxWidth: 720,
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
                child: _OverviewGrid(progress: progress, isWide: isWide),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppReveal(
                index: 1,
                child: _CefrSection(levels: progress.levelBreakdown),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppReveal(
                index: 2,
                child: _WeakWordsSection(weakWords: progress.weakWords),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        );
      },
    );
  }
}

class _OverviewGrid extends StatelessWidget {
  const _OverviewGrid({required this.progress, required this.isWide});

  final VocabularyProgress progress;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final cards = [
      AppStatCard(
        icon: Icons.menu_book_outlined,
        value: '${progress.wordsPracticed}',
        label: 'Words practiced',
      ),
      AppStatCard(
        icon: Icons.repeat_rounded,
        value: '${progress.totalAttempts}',
        label: 'Total attempts',
      ),
      AppStatCard(
        icon: Icons.check_circle_outline,
        value: '${progress.correctAnswers}',
        label: 'Correct answers',
        accentColor: context.semanticColors.success,
      ),
      AppStatCard(
        icon: Icons.cancel_outlined,
        value: '${progress.incorrectAnswers}',
        label: 'Incorrect answers',
        accentColor: Theme.of(context).colorScheme.error,
      ),
      AppStatCard(
        icon: Icons.flash_on_outlined,
        value: progress.firstTryAccuracyPercent != null
            ? '${progress.firstTryAccuracyPercent}%'
            : '—',
        label: 'First-try accuracy',
      ),
      AppStatCard(
        icon: Icons.track_changes_outlined,
        value: progress.overallAccuracyPercent != null
            ? '${progress.overallAccuracyPercent}%'
            : '—',
        label: 'Overall accuracy',
      ),
      AppStatCard(
        icon: Icons.local_fire_department_rounded,
        value: '${progress.currentStreakDays}',
        label: 'Current streak',
        accentColor: context.semanticColors.streak,
      ),
      AppStatCard(
        icon: Icons.workspace_premium_outlined,
        value: '${progress.wordsMastered}',
        label: 'Words mastered',
      ),
    ];

    return GridView.count(
      crossAxisCount: isWide ? 4 : (MediaQuery.sizeOf(context).width > 420 ? 3 : 2),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.15,
      children: cards,
    );
  }
}

class _CefrSection extends StatelessWidget {
  const _CefrSection({required this.levels});

  final List<CefrLevelProgress> levels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Progress by CEFR level', style: theme.textTheme.titleMedium),
        const SizedBox(height: 2),
        Text(
          'Your vocabulary progress in this app\'s Oxford 3000 list — '
          'not an official CEFR assessment.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.md),
        if (levels.isEmpty)
          Text('No CEFR-tagged words yet.', style: theme.textTheme.bodyMedium)
        else
          ...levels.map(
            (level) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _CefrLevelCard(level: level),
            ),
          ),
      ],
    );
  }
}

class _CefrLevelCard extends StatelessWidget {
  const _CefrLevelCard({required this.level});

  final CefrLevelProgress level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(level.level.label, style: theme.textTheme.titleMedium),
              Text(
                level.hasAccuracyData ? '${level.accuracyPercent}% accuracy' : '—',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          AppProgressBar(progress: level.practicedFraction),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${level.practicedWords} / ${level.totalWords} words practiced · '
            '${level.masteredWords} mastered',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _WeakWordsSection extends StatelessWidget {
  const _WeakWordsSection({required this.weakWords});

  final List<WeakWord> weakWords;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Weak Words', style: theme.textTheme.titleMedium),
        const SizedBox(height: 2),
        Text(
          'Words you frequently get wrong — worth extra review.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.md),
        if (weakWords.isEmpty)
          AppCard(
            child: Text(
              'No weak words yet. Keep practicing and any words you '
              'often miss will show up here.',
              style: theme.textTheme.bodyMedium,
            ),
          )
        else
          ...weakWords.map(
            (weakWord) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _WeakWordCard(weakWord: weakWord),
            ),
          ),
      ],
    );
  }
}

class _WeakWordCard extends StatelessWidget {
  const _WeakWordCard({required this.weakWord});

  final WeakWord weakWord;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.error.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.priority_high_rounded,
              color: theme.colorScheme.error,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(weakWord.word.headword, style: theme.textTheme.titleMedium),
                Text(
                  '${weakWord.timesIncorrect} wrong of ${weakWord.timesReviewed} '
                  'attempts',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Text(
            '${weakWord.accuracyPercent}%',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
