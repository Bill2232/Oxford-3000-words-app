import 'package:flutter/material.dart';

import '../theme/app_motion.dart';

/// Fades and slides its child in shortly after first build. Give sibling
/// sections increasing [index] values to get a staggered entrance instead
/// of everything appearing at once.
class AppReveal extends StatefulWidget {
  const AppReveal({required this.child, this.index = 0, super.key});

  final Widget child;
  final int index;

  @override
  State<AppReveal> createState() => _AppRevealState();
}

class _AppRevealState extends State<AppReveal> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 60 * widget.index), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: AppMotion.medium,
      curve: AppMotion.standard,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, 0.04),
        duration: AppMotion.medium,
        curve: AppMotion.standard,
        child: widget.child,
      ),
    );
  }
}
