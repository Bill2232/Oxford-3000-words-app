import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Standard screen scaffold: consistent app bar + horizontal padding so
/// individual screens don't repeat that boilerplate.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.padHorizontal = true,
    super.key,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool padHorizontal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(title: Text(title!), actions: actions),
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Padding(
          padding: padHorizontal
              ? const EdgeInsets.symmetric(horizontal: AppSpacing.md)
              : EdgeInsets.zero,
          child: body,
        ),
      ),
    );
  }
}
