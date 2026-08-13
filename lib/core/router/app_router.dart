import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/word.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/practice/presentation/practice_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/statistics/presentation/statistics_screen.dart';
import '../../features/theme_selector/presentation/theme_selector_screen.dart';
import '../../features/word_detail/presentation/word_detail_screen.dart';
import '../../features/word_explanation/presentation/explanation_screen.dart';
import '../../features/word_list/presentation/word_list_screen.dart';
import '../widgets/app_button.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/empty_state.dart';
import 'app_page_transitions.dart';

/// Route path/name constants so screens never hard-code path strings.
abstract final class AppRoutes {
  static const home = '/';
  static const wordList = '/words';
  static const wordDetail = '/words/:id';
  static const practice = '/practice';
  static const explanation = '/explanation';
  static const statistics = '/statistics';
  static const settings = '/settings';
  static const themeSelector = '/settings/theme';

  static String wordDetailPath(int id) => '/words/$id';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    errorBuilder: (context, state) => AppScaffold(
      title: 'Not found',
      body: EmptyState(
        icon: Icons.error_outline,
        message: "That page doesn't exist.",
        action: AppButton(
          label: 'Back to home',
          variant: AppButtonVariant.outlined,
          onPressed: () => context.go(AppRoutes.home),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        pageBuilder: (context, state) =>
            buildAppPage(state: state, child: const HomeScreen()),
      ),
      GoRoute(
        path: AppRoutes.wordList,
        name: 'wordList',
        pageBuilder: (context, state) =>
            buildAppPage(state: state, child: const WordListScreen()),
      ),
      GoRoute(
        path: AppRoutes.wordDetail,
        name: 'wordDetail',
        // A non-numeric id (typed URL, stale/bad deep link) would otherwise
        // throw inside `int.parse` while building the page — redirect to
        // the word list instead of crashing.
        redirect: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          return id == null ? AppRoutes.wordList : null;
        },
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return buildAppPage(state: state, child: WordDetailScreen(wordId: id));
        },
      ),
      GoRoute(
        path: AppRoutes.practice,
        name: 'practice',
        pageBuilder: (context, state) =>
            buildAppPage(state: state, child: const PracticeScreen()),
      ),
      GoRoute(
        path: AppRoutes.explanation,
        name: 'explanation',
        // `extra` only exists for in-app navigation (it's not encoded in
        // the URL), so it's always null after a browser refresh/deep link
        // on web, or if this route is ever reached some other way. Redirect
        // instead of crashing on a null-assertion.
        redirect: (context, state) =>
            state.extra is Word ? null : AppRoutes.home,
        pageBuilder: (context, state) => buildAppPage(
          state: state,
          child: ExplanationScreen(word: state.extra! as Word),
        ),
      ),
      GoRoute(
        path: AppRoutes.statistics,
        name: 'statistics',
        pageBuilder: (context, state) =>
            buildAppPage(state: state, child: const StatisticsScreen()),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        pageBuilder: (context, state) =>
            buildAppPage(state: state, child: const SettingsScreen()),
      ),
      GoRoute(
        path: AppRoutes.themeSelector,
        name: 'themeSelector',
        pageBuilder: (context, state) =>
            buildAppPage(state: state, child: const ThemeSelectorScreen()),
      ),
    ],
  );
});
