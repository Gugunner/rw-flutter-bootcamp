import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/master_policy/domain/model/master_policy_model.dart';
import 'package:accesible_insurance_capstone_project/master_policy/utils/master_policy_utils.dart';
import 'package:accesible_insurance_capstone_project/policy_store/ui/store_screen.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/imago.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/auth_utils.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedLogoMatrix extends ConsumerStatefulWidget {
  const AnimatedLogoMatrix({
    super.key,
    required this.type,
  });

  final PolicyType type;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AnimatedLogoMatrixState();
}

class _AnimatedLogoMatrixState extends ConsumerState<AnimatedLogoMatrix>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<Tween<RelativeRect>> positionTween;
  late MasterPolicyModel masterPolicy;
  AsyncValue<void>? creatingPolicy;

  @override
  void initState() {
    masterPolicy = createDemoPolicy(
      ref,
      type: widget.type,
    );
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
    return ref
        .watch(
      MasterPoliciesProvider.instance.createMasterPolicyProvider(masterPolicy),
    )
        .when(data: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Success Buying the Policy!',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          TextButton(
            onPressed: () {
              controller.stop();
              ref.read(buyinPolicyProvider.notifier).state = false;
            },
            child: Text('ACCEPT'),
          ),
          SizedBox(
            height: context.height * 0.0233,
          ),
          Icon(
            Icons.check_circle_outline_rounded,
            color: Theme.of(context).primaryColor,
            size: 48,
          ),
        ],
      );
    }, error: (error, stackTrace) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error Buying the Policy',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          TextButton(
            onPressed: () {
              controller.stop();
              ref.read(buyinPolicyProvider.notifier).state = false;
            },
            child: Text('GO BACK'),
          ),
          SizedBox(
            height: context.height * 0.0233,
          ),
          Icon(
            Icons.check_circle_outline_rounded,
            color: Theme.of(context).errorColor,
            size: 48,
          ),
        ],
      );
    }, loading: () {
      return Stack(
        children: [
          SizedBox(
            width: context.width,
            height: context.height,
          ),
          ..._buildMatrix(context),
        ],
      );
    });
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
