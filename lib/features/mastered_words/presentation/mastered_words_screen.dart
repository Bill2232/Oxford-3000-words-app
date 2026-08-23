import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_confirm_dialog.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../core/widgets/word_pronounce_button.dart';
import '../application/mastered_word_entry.dart';
import '../application/mastered_words_actions.dart';
import '../application/mastered_words_provider.dart';

class MasteredWordsScreen extends ConsumerWidget {
  const MasteredWordsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(masteredWordsProvider);

    return AppScaffold(
      title: 'Mastered Words',
      padHorizontal: false,
      body: entriesAsync.when(
        loading: () => const LoadingIndicator(message: 'Loading mastered words…'),
        error: (error, stackTrace) => EmptyState(
          icon: Icons.error_outline,
          message: 'Could not load your mastered words. Please try again.',
          onRetry: () => ref.invalidate(masteredWordsProvider),
        ),
        data: (entries) {
          if (entries.isEmpty) {
            return const EmptyState(
              icon: Icons.star_outline_rounded,
              message: 'No mastered words yet. During practice, mark a '
                  "word as mastered once you're confident you know it — "
                  "it'll show up here.",
            );
          }
          return ResponsiveCenter(
            maxWidth: 720,
            builder: (context, isWide) {
              final horizontalPadding = isWide ? AppSpacing.xl : AppSpacing.md;
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      AppSpacing.sm,
                      horizontalPadding,
                      AppSpacing.sm,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${entries.length} '
                            '${entries.length == 1 ? 'word' : 'words'} mastered',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        AppButton(
                          label: 'Review',
                          icon: Icons.refresh_rounded,
                          variant: AppButtonVariant.gradient,
                          onPressed: () => context.push(AppRoutes.masteredReview),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: AppSpacing.sm,
                      ),
                      itemCount: entries.length,
                      itemBuilder: (context, index) {
                        final entry = entries[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: _MasteredWordCard(entry: entry),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _MasteredWordCard extends ConsumerWidget {
  const _MasteredWordCard({required this.entry});

  final MasteredWordEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final word = entry.word;
    final masteredAt = entry.masteredAt;

    return AppCard(
      onTap: () => context.push(AppRoutes.wordDetailPath(word.id)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(word.headword, style: theme.textTheme.titleMedium),
                Text(
                  '${word.cefrLevel.label} · ${word.partOfSpeech.label} · '
                  '${entry.automaticMasteryLevel.label}',
                  style: theme.textTheme.bodyMedium,
                ),
                if (masteredAt != null)
                  Text(
                    'Mastered ${_formatDate(masteredAt)}',
                    style: theme.textTheme.bodySmall,
                  ),
              ],
            ),
          ),
          WordPronounceButton(headword: word.headword),
          const SizedBox(width: AppSpacing.xs),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline),
            tooltip: 'Remove from Mastered Words',
            onPressed: () async {
              final result = await showAppConfirmDialog(
                context,
                title: 'Remove from Mastered Words?',
                message:
                    '"${word.headword}" will go back into normal practice.',
                confirmLabel: 'Remove',
                isDestructive: true,
              );
              if (result.confirmed) {
                await removeFromMastered(ref, word.id);
              }
            },
          ),
        ],
      ),
    );
  }
}

const _monthNames = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _formatDate(DateTime date) =>
    '${_monthNames[date.month - 1]} ${date.day}, ${date.year}';
