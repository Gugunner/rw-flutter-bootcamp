import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///Calls predefined transitions to be used inside the app.
class CustomTransitions {
  ///Use to create a custom sliding transition animation/
  ///
  ///Defaults to sliding from bottom to top.
  static CustomTransitionPage<T> slideFromTo<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,

    ///Use duration to change how long it takes to animate
    Duration? duration,

    ///Intiial [dx,dy] position of screen defaults to [0.0, 1.0]
    Offset? begin,

    ///Final [dx,dy] position of screen defaults to [0.0, 0.0]
    Offset? end,

    ///The curve animation uses values of [Curves]
    Curve? curve,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration ?? const Duration(seconds: 6),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        const curve = Curves.ease;
        final tween = Tween(
          begin: begin ?? const Offset(0.0, 1.0),
          end: end ?? Offset.zero,
        ).chain(
          CurveTween(curve: curve),
        );
        final offSetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offSetAnimation,
          child: child,
        );
      },
    );
  }

  ///Use to create a custom scaling transition animation
  ///
  ///Defaults to scaling from horizontal and vertical center of screen up to
  ///each screen edge.
  static CustomTransitionPage<T> scaleFromTo<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,

    ///Use duration to change how long it takes to animate
    Duration? duration,

    ///Intiial size of screen defaults to 0.0
    double? begin,

    ///Final size of screen defaults to 1.0
    double? end,

    ///The curve animation uses values of [Curves]
    Curve? curve,
  }) {
    return CustomTransitionPage<T>(
      child: child,
      transitionDuration: duration ?? const Duration(milliseconds: 300),
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        final tween = Tween(
          begin: begin ?? 0.0,
          end: end ?? 1.0,
        ).chain(
          CurveTween(
            curve: curve ?? Curves.ease,
          ),
        );
        return ScaleTransition(
          scale: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static PageRouteBuilder<T> defaultTransition<T>({
    required Widget child,
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
  }) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) {
        return child;
      },
    );
  }
}
