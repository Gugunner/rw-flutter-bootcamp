import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/shared_preferences_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/imago.dart';
import 'package:accesible_insurance_capstone_project/universal_app/ui/widgets/transition/rotate_transition.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/copies/english_copies.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedSignInLogo extends ConsumerStatefulWidget {
  const AnimatedSignInLogo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends ConsumerState<AnimatedSignInLogo>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  double? top;
  double opacity = 0;

  int get rotationCycle => 400; //milliseconds

  int get moveCycle => 800; //milliseconds

  int get delayMoveCycle => 200; //milliseconds

  int get opacityCycle => 500; //milliseconds

  int get delaySignIn => 2; //seconds

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(milliseconds: rotationCycle),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
          Duration(
            milliseconds: delayMoveCycle,
          ), () {
        setState(() {
          top = context.height * 0.425;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOnboarding = SharedPreferencesProvider.instance.isOnboarding();
    return AnimatedPositioned(
      left: context.width * 0.375,
      top: top ?? context.height * 0.1128,
      duration: Duration(
        milliseconds: moveCycle,
      ),
      onEnd: () {
        controller.repeat();
        setState(() {
          opacity = 1;
        });
        Future.delayed(Duration(seconds: delaySignIn), () {
          var route = '';
          controller.stop();
          if (isOnboarding) {
            route = AppRoutes.onboarding.route;
          } else {
            route = AppRoutes.home.route;
          }
          ref.read(routeProvider.notifier).state = route;
        });
      },
      curve: Curves.fastOutSlowIn,
      child: Column(
        children: [
          RotationTransition(
            turns: animation,
            child: RotateTransition(
              animation: animation,
              child: const Imago(),
            ),
          ),
          AnimatedOpacity(
            opacity: opacity,
            duration: Duration(
              milliseconds: opacityCycle,
            ),
            child: Container(
              margin: EdgeInsets.only(
                top: context.height * 0.028,
              ),
              child: Text(
                isOnboarding ? EnglishCopies.start : EnglishCopies.welcomeBack,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
