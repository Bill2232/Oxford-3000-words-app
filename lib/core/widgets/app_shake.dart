import 'package:flutter/material.dart';

/// Wraps [child] with a brief horizontal shake, replayed every time
/// [trigger] changes value. Used for "that's wrong" feedback without
/// needing a bespoke [AnimationController] at every call site.
class AppShake extends StatefulWidget {
  const AppShake({required this.trigger, required this.child, super.key});

  final Object trigger;
  final Widget child;

  @override
  State<AppShake> createState() => _AppShakeState();
}

class _AppShakeState extends State<AppShake> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );
  late final Animation<double> _offset = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -10, end: 10), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 10, end: -6), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 6, end: 0), weight: 1),
  ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  @override
  void didUpdateWidget(covariant AppShake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger != oldWidget.trigger) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) => Transform.translate(
        offset: Offset(_offset.value, 0),
        child: child,
      ),
      child: widget.child,
    );
  }
}
