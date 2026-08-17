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
import '../../../core/widgets/word_pronounce_button.dart';
import '../../../domain/entities/word.dart';
import 'word_list_providers.dart';

class WordListScreen extends ConsumerStatefulWidget {
  const WordListScreen({super.key});

  @override
  ConsumerState<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends ConsumerState<WordListScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Word> _filter(List<Word> words) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return words;
    return words
        .where((word) => word.headword.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
          final filtered = _filter(words);
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
                      0,
                    ),
                    child: TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Search words',
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: _query.isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.clear_rounded),
                                tooltip: 'Clear search',
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _query = '');
                                },
                              ),
                      ),
                      onChanged: (value) => setState(() => _query = value),
                    ),
                  ),
                  Expanded(
                    child: filtered.isEmpty
                        ? EmptyState(
                            message: 'No words match "$_query".',
                            icon: Icons.search_off_rounded,
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                              vertical: AppSpacing.sm,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final word = filtered[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.sm,
                                ),
                                child: AppCard(
                                  onTap: () => context
                                      .push(AppRoutes.wordDetailPath(word.id)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              word.headword,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            Text(
                                              '${word.partOfSpeech.label} · '
                                              '${word.cefrLevel.label}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      WordPronounceButton(
                                        headword: word.headword,
                                      ),
                                      const SizedBox(width: AppSpacing.xs),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                    ],
                                  ),
                                ),
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
