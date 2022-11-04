import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/imago.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedLogoMatrix extends ConsumerStatefulWidget {
  const AnimatedLogoMatrix({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedLogoMatrixState();
}

class _AnimatedLogoMatrixState extends ConsumerState<AnimatedLogoMatrix>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<Tween<RelativeRect>> positionTween;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: context.width,
          height: context.height,
        ),
        ..._buildMatrix(context),
      ],
    );
  }

  //TODO: Make the DRY with a simple loop
  List<PositionedTransition> _buildMatrix(BuildContext context) {
    return [
      ///An explicit animation is used that based
      ///on the container size starts from the middle
      ///and then moves to a different corner.
      PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromSize(
            Rect.fromLTWH(
              context.width * 0.292,
              context.height * 0.375,
              context.height * 0.25,
              context.height * 0.25,
            ),
            MediaQuery.of(context).size,
          ),
          end: RelativeRect.fromSize(
            Rect.fromLTWH(
              -context.width * 0.1,
              0,
              context.height * 0.25,
              context.height * 0.25,
            ),
            MediaQuery.of(context).size,
          ),
        )
            //In this case tha Animation was set from inside the
            //animate method call.
            .animate(
          CurvedAnimation(parent: controller, curve: Curves.ease),
        ),
        //A rotation animation is used and since the controller
        //has a repeat(reverse: true) it goes forward and backward
        child: RotationTransition(
          turns: CurvedAnimation(
            parent: controller,
            curve: Curves.linear,
          ),
          child: AnimatedLogoMatrixPoint(controller: controller),
        ),
      ),
      PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromSize(
            Rect.fromLTWH(
              context.width * 0.292,
              context.height * 0.375,
              context.height * 0.25,
              context.height * 0.25,
            ),
            MediaQuery.of(context).size,
          ),
          end: RelativeRect.fromSize(
            Rect.fromLTWH(
              context.width * 0.688,
              0,
              context.height * 0.25,
              context.height * 0.25,
            ),
            MediaQuery.of(context).size,
          ),
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.ease),
        ),
        child: RotationTransition(
          turns: CurvedAnimation(
            parent: controller,
            curve: Curves.linear,
          ),
          child: AnimatedLogoMatrixPoint(controller: controller),
        ),
      ),
      PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromSize(
            Rect.fromLTWH(
              context.width * 0.292,
              context.height * 0.375,
              context.height * 0.25,
              context.height * 0.25,
            ),
            MediaQuery.of(context).size,
          ),
          end: RelativeRect.fromSize(
            Rect.fromLTWH(
              -context.width * 0.1,
              context.height * 0.75,
              context.height * 0.25,
              context.height * 0.25,
            ),
            MediaQuery.of(context).size,
          ),
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.ease),
        ),
        child: RotationTransition(
          turns: CurvedAnimation(
            parent: controller,
            curve: Curves.linear,
          ),
          child: AnimatedLogoMatrixPoint(controller: controller),
        ),
      ),
      PositionedTransition(
        rect: RelativeRectTween(
          begin: RelativeRect.fromSize(
            Rect.fromLTWH(
              context.width * 0.292,
              context.height * 0.375,
              context.height * 0.25,
              context.height * 0.25,
            ),
            MediaQuery.of(context).size,
          ),
          end: RelativeRect.fromSize(
            Rect.fromLTWH(
              context.width * 0.688,
              context.height * 0.75,
              context.height * 0.25,
              context.height * 0.25,
            ),
            MediaQuery.of(context).size,
          ),
        ).animate(
          CurvedAnimation(parent: controller, curve: Curves.ease),
        ),
        child: RotationTransition(
          turns: CurvedAnimation(
            parent: controller,
            curve: Curves.linear,
          ),
          child: AnimatedLogoMatrixPoint(controller: controller),
        ),
      ),
    ];
  }
}

class AnimatedLogoMatrixPoint extends AnimatedWidget {
  const AnimatedLogoMatrixPoint({
    super.key,
    required AnimationController controller,
    //An animated widget always needs to pass a notifier
  }) : super(listenable: controller);

  //Gets the listenable value each time the widget rebuilds
  Animation<double> get _opacity => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: _opacity.value, child: const Imago());
  }
}