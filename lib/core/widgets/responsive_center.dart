import 'package:flutter/material.dart';

/// Centers content and caps its width on wide (desktop/web) viewports,
/// while letting narrow (mobile) viewports use the full width. Exposes
/// `isWide` to the builder so callers can also adapt grid column counts,
/// padding, etc. — the one respond-to-viewport-width decision every
/// scrollable screen in this app needs, previously duplicated with a
/// slightly different copy of the same `LayoutBuilder` in each screen.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    required this.builder,
    this.maxWidth = 640,
    this.wideBreakpoint = 720,
    super.key,
  });

  final Widget Function(BuildContext context, bool isWide) builder;
  final double maxWidth;
  final double wideBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > wideBreakpoint;
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: builder(context, isWide),
          ),
        );
      },
    );
  }
}
