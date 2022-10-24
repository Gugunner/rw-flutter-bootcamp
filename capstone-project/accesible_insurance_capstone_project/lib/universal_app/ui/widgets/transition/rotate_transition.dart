import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RotateTransition extends ConsumerWidget {
  const RotateTransition({
    super.key,
    required this.animation,
    required this.child,
  });

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (
          context,
          child,
        ) {
          return SizedBox(
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}