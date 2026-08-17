import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/app_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(selectedPaletteProvider);

    return AppScaffold(
      title: 'Settings',
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        children: [
          ListTile(
            leading: const Icon(Icons.menu_book_outlined),
            title: const Text('Browse words'),
            subtitle: const Text('The full Oxford 3000 word list'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.wordList),
          ),
          ListTile(
            leading: const Icon(Icons.insights_outlined),
            title: const Text('Vocabulary progress'),
            subtitle: const Text('Stats, CEFR breakdown, weak words'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.statistics),
          ),
          ListTile(
            leading: const Icon(Icons.record_voice_over_outlined),
            title: const Text('Pronunciation'),
            subtitle: const Text('British or American accent'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.pronunciationSelector),
          ),
          ListTile(
            leading: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: palette.primaryGradient,
                shape: BoxShape.circle,
              ),
            ),
            title: const Text('App theme'),
            subtitle: Text(palette.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(AppRoutes.themeSelector),
          ),
        ],
      ),
    );
  }
}
