import 'dart:math';

import 'package:accesible_insurance_capstone_project/child_policies/domain/provider/child_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/child_policy/domain/model/child_policy_model.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AnimatedChildPolicyZone extends ConsumerStatefulWidget {
  const AnimatedChildPolicyZone({super.key, required this.index});

  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedChildPoliciesState();
}

class _AnimatedChildPoliciesState
    extends ConsumerState<AnimatedChildPolicyZone> {
  double width = 20;

  double height = 20;

  double opacity = 0;

  Duration opacityDuration = const Duration(milliseconds: 200);

  Duration containerDuration = const Duration(milliseconds: 300);

  double topRadius = 100;

  double bottomRadius = 100;

  AlignmentGeometry alignment = Alignment.bottomCenter;

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
    Future.delayed(const Duration(milliseconds: 180), () {
      if (mounted) {
        setState(() {
          width = context.width * 0.2;
          height = context.width * 0.2;
          opacity = 1;
        });
      }
    })
        //After the initial values are set, the widget starts
        //to change size and create a radius to look as a rounded shape
        .then((_) {
      if (mounted) {
        setState(() {
          width = context.width;
          height = context.width * 1.05;
          topRadius = context.width * 0.15;
          bottomRadius = 0;
        });
      }
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
        child: AnimatedContainer(
          width: width,
          height: height,
          duration: containerDuration,
          padding: EdgeInsets.symmetric(
            vertical: context.height * 0.025,
            horizontal: context.width * 0.05,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(topRadius),
              bottom: Radius.circular(bottomRadius),
            ),
            color: Theme.of(context).primaryColor.withOpacity(0.9),
          ),
          onEnd: () {
            debugPrint('End');
          },
          curve: Curves.elasticOut,
          child: ChildPolicyZoneContent(
            index: widget.index,
          ),
        ),
      ),
    );
  }
}

class ChildPolicyZoneContent extends ConsumerWidget {
  const ChildPolicyZoneContent({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childPolicies = ref
        .watch(childPoliciesProviderInstance
            .childPoliciesStreamer('qfrgafACPuaYdGnVVTaE'))
        .when(data: (childPolicies) {
      return childPolicies;
    }, error: (e, stacktrace) {
      return [];
    }, loading: () {
      return [];
    });
    return SizedBox(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: context.height * 0.05),
            height: context.height * 0.45,
            color: Colors.red,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Text('${childPolicies[index].childPolicyId}');
              },
              itemCount: childPolicies.length,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // final route = AppRoutes.upgrade.upgradePolicyRoute(index);
              // context.go(route);
              // ref.read(routeProvider.notifier).state = route;
              final childPolicyId = Random().nextInt(99999999);
              final randomPremiumPaid = Random().nextDouble() * 20.99 + 3.99;
              final randomSumInsured =
                  Random().nextDouble() * (randomPremiumPaid * 140);
              final nowDate = DateTime.now();
              final nextDate = nowDate.add(const Duration(days: 365));
              final childPolicy = ChildPolicyModel(
                childPolicyId: childPolicyId,
                masterPolicyId: 'qfrgafACPuaYdGnVVTaE',
                premiumPaid: randomPremiumPaid,
                sumInsured: randomSumInsured,
                activeSinceDate: DateTime.now(),
                expirationDate:
                    DateTime(nextDate.year, nextDate.month, nextDate.day),
              );
              ref
                  .watch(childPoliciesProviderInstance
                      .childPolicyInsertProvider(childPolicy))
                  .when(
                      data: (int id) {},
                      error: (e, stacktrace) {
                        debugPrint('Could not insert child policy');
                      },
                      loading: () {
                        debugPrint('loading');
                      });
            },
            child: Text(
              'Go to Store',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
