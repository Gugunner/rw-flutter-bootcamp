import 'dart:async';

import 'package:accesible_insurance_capstone_project/child_policy/ui/widgets/child_policies_zone.dart';
import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedChildPolicyZone extends ConsumerStatefulWidget {
  const AnimatedChildPolicyZone({
    super.key,
    required this.masterPolicy,
  });

  final MasterPolicyModel masterPolicy;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedChildPoliciesState();
}

class _AnimatedChildPoliciesState
    extends ConsumerState<AnimatedChildPolicyZone> {
  double? width;

  double height = 20;

  double opacity = 0;

  Duration opacityDuration = const Duration(milliseconds: 200);

  Duration containerDuration = const Duration(milliseconds: 300);

  double topRadius = 100;

  double bottomRadius = 0;

  AlignmentGeometry alignment = Alignment.bottomCenter;

  Curve containerCurve = Curves.elasticOut;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animateIt();
    });
    super.initState();
  }

  void animateIt() {
    //Once the widget has been built the first time a timer starts
    //to change width, height and opacity. The timer is to
    //prevent any animation from ocurring while the Hero animation finishes
    //due to the layer building while transitioning.
    Timer.periodic(const Duration(milliseconds: 180), (timer) {
      if (mounted) {
        setState(() {
          width = context.width;
          height = context.height * 0.1;
          topRadius = context.width * 0.15;
          bottomRadius = 0;
          opacity = 0.9;
          containerCurve = Curves.fastLinearToSlowEaseIn;
        });
      }
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    //Uses animated align since it is wrapped by a Stack widget
    //The animation is created by stacking several AnimatedImplicitWidgets
    return AnimatedAlign(
      duration: const Duration(seconds: 0),
      alignment: Alignment.bottomCenter,
      curve: Curves.easeInOutSine,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: opacityDuration,
        curve: Curves.easeInOutExpo,
        child: GestureDetector(
          //TODO: Change to onPanEnd with velocity
          //TODO: Move into its own method
          onPanStart: (details) {
            final dy = details.globalPosition.dy;
            if (dy >= context.height * 0.8) {
              setState(() {
                height = context.height;
                opacity = 1;
                topRadius = 8;
              });
            } else if (dy <= context.height * 0.2) {
              setState(() {
                height = context.height * 0.1;
                opacity = 0.9;
                topRadius = context.width * 0.15;
              });
            }
          },
          child: AnimatedContainer(
            width: width ?? context.width,
            height: height,
            duration: containerDuration,
            padding: EdgeInsets.fromLTRB(
              context.width * 0.0,
              context.height * 0.1,
              context.width * 0.0,
              context.height * 0.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(topRadius),
                bottom: Radius.circular(bottomRadius),
              ),
              color: Theme.of(context).primaryColor,
            ),
            onEnd: () {
              debugPrint('End');
            },
            curve: containerCurve,
            //TODO: Make widget appear when container has finished growing
            //TODO: Make widget disappear when container has finished shrninking
            child: ChildPoliciesZone(
              masterPolicy: widget.masterPolicy,
            ),
          ),
        ),
      ),
    );
  }
}
