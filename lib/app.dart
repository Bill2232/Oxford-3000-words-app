import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_motion.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

class WordlyApp extends ConsumerWidget {
  const WordlyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final palette = ref.watch(selectedPaletteProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.from(palette),
      themeAnimationDuration: AppMotion.themeSwitch,
      themeAnimationCurve: AppMotion.standard,
      routerConfig: router,
    );
  }
}
