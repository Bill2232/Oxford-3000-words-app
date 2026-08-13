import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/responsive_center.dart';
import 'word_list_providers.dart';

class WordListScreen extends ConsumerWidget {
  const WordListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordsAsync = ref.watch(wordListProvider);

    return AppScaffold(
      title: 'Words',
      padHorizontal: false,
      body: wordsAsync.when(
        loading: () => const LoadingIndicator(message: 'Loading words…'),
        error: (error, stackTrace) => EmptyState(
          icon: Icons.error_outline,
          message: 'Could not load words. Please try again.',
          onRetry: () => ref.invalidate(wordListProvider),
        ),
        data: (words) {
          if (words.isEmpty) {
            return const EmptyState(
              message: 'No words yet.',
              icon: Icons.menu_book_outlined,
            );
          }
          return ResponsiveCenter(
            maxWidth: 720,
            builder: (context, isWide) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? AppSpacing.xl : AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                itemCount: words.length,
                itemBuilder: (context, index) {
                  final word = words[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: AppCard(
                      onTap: () =>
                          context.push(AppRoutes.wordDetailPath(word.id)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  word.headword,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  '${word.partOfSpeech.label} · ${word.cefrLevel.label}',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
