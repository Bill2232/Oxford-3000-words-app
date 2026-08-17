import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/responsive_center.dart';
import '../../../core/widgets/word_pronounce_button.dart';
import '../../../domain/entities/word.dart';
import '../../../providers/database_provider.dart';

// `autoDispose` so browsing many words over a session doesn't leave every
// past word's query cached for the app's lifetime.
final _wordDetailProvider =
    FutureProvider.autoDispose.family<Word?, int>((ref, wordId) async {
  return ref.watch(wordRepositoryProvider).getWordById(wordId);
});

class WordDetailScreen extends ConsumerWidget {
  const WordDetailScreen({required this.wordId, super.key});

  final int wordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wordAsync = ref.watch(_wordDetailProvider(wordId));

    return AppScaffold(
      title: 'Word detail',
      body: wordAsync.when(
        loading: () => const LoadingIndicator(message: 'Loading word…'),
        error: (error, stackTrace) => EmptyState(
          icon: Icons.error_outline,
          message: 'Could not load this word. Please try again.',
          onRetry: () => ref.invalidate(_wordDetailProvider(wordId)),
        ),
        data: (word) {
          if (word == null) {
            return const EmptyState(
              icon: Icons.search_off,
              message: 'Word not found.',
            );
          }
          return _WordDetailContent(word: word);
        },
      ),
    );
  }
}

class _WordDetailContent extends StatelessWidget {
  const _WordDetailContent({required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ResponsiveCenter(
      builder: (context, isWide) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? AppSpacing.xl : 0,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      word.headword,
                      style: theme.textTheme.displayLarge,
                    ),
                  ),
                  WordPronounceButton(headword: word.headword, size: 44),
                ],
              ),
              if (word.phoneticSpelling != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Text(
                    word.phoneticSpelling!,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${word.partOfSpeech.label} · ${word.cefrLevel.label}',
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Definition', style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(word.definition, style: theme.textTheme.bodyLarge),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Example', style: theme.textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      word.exampleSentence,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
