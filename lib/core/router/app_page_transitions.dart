import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_motion.dart';

/// One consistent transition for every route, so navigation feels the same
/// on mobile, desktop, and web instead of falling back to each platform's
/// default (a slide-from-right on Android, an instant cut on desktop/web).
/// A soft fade + slight upward slide reads as "polished" everywhere without
/// depending on platform-specific page-transition builders.
CustomTransitionPage<T> buildAppPage<T>({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: AppMotion.medium,
    reverseTransitionDuration: AppMotion.medium,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: AppMotion.standard);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.02),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}
