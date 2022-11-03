import 'package:accesible_insurance_capstone_project/master_policies/domain/provider/master_policies_provider.dart';
import 'package:accesible_insurance_capstone_project/master_policies/ui/master_policy_list_screen.dart';
import 'package:accesible_insurance_capstone_project/master_policy/ui/master_policy_screen.dart';
import 'package:accesible_insurance_capstone_project/policy_store/ui/upgrade_policy_screen.dart';
import 'package:accesible_insurance_capstone_project/profile/ui/profile_screen.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/onboarding_screen.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/sign_in_screen.dart';
import 'package:accesible_insurance_capstone_project/sign_up/ui/sign_up_screen.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/animations/page_transitions/custom_transitions.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routeProvider = StateProvider<String>((ref) => '/signin');

class AppRouter extends ChangeNotifier {
  final Ref ref;

  AppRouter(this.ref) {
    ref.listen(
      routeProvider,
      (previous, next) => notifyListeners(),
    );
  }

  ///Reads a [GoRouterState] and compares it to the [routeProvider] state.
  ///
  ///If it is the same it returns null.
  ///If it is different it returns the [stateRoute].
  ///Has a special launch condition where a specific route must be
  ///provided [signin].
  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    //Boolean value to know if user has already signed in
    final signIn = ref.read(AppProvider.instance.signIn);
    //String value that returns current route to navigate to
    final stateRoute = ref.read(routeProvider.state).state;
    //Checks if location and stateRoute are the same to avoid infinite loops
    if (state.location == stateRoute) {
      return null;
    }
    //TODO: Check if signIn is no longer needed adn instead read auth
    //changes for firebase user
    //Redirects to [signin] route only if user ahs not signed in
    if (!signIn) {
      if (state.location == AppRoutes.signin.route) {
        return AppRoutes.signin.route;
      } else if (state.location == AppRoutes.signup.route) {
        return AppRoutes.signup.route;
      }
    }
    //Returns the route to navigate to
    return stateRoute;
  }

  //List of routes for the navigator
  List<GoRoute> get routes => [
        GoRoute(
          name: AppRoutes.signin.name,
          path: AppRoutes.signin.route,
          //Use builder if default transition is used
          builder: (BuildContext context, GoRouterState state) {
            return const SignInScreen();
          },
        ),
        GoRoute(
          name: AppRoutes.signup.name,
          path: AppRoutes.signup.route,
          //Use builder if default transition is used
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          name: AppRoutes.onboarding.name,
          path: AppRoutes.onboarding.route,
          //Use pageBuilder when a custom transition is necessary
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitions.slideFromTo<void>(
              context: context,
              state: state,
              child: const OnboardingScreen(),
              duration: const Duration(milliseconds: 1500),
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
              curve: Curves.easeInOut,
            );
          },
        ),
        GoRoute(
          name: AppRoutes.home.name,
          path: AppRoutes.home.route,
          builder: (BuildContext context, GoRouterState state) {
            return const MasterPolicyListScreen();
          },
          routes: <GoRoute>[
            GoRoute(
              name: AppRoutes.profile.name,
              path: AppRoutes.profile.route,
              builder: (BuildContext context, GoRouterState state) {
                return const ProfileScreen();
              },
            ),
            GoRoute(
                name: AppRoutes.policy.name,
                path: '${AppRoutes.policy.route}:index',
                builder: (BuildContext context, GoRouterState state) {
                  final masterPolicies = ref
                      .read(
                          MasterPoliciesProvider.instance.masterPolicies.state)
                      .state;
                  final index = num.parse(state.params['index']!) as int;
                  final masterPolicy = masterPolicies[index];
                  return MasterPolicyScreen(
                    index: index,
                  );
                },
                routes: [
                  GoRoute(
                    name: AppRoutes.upgrade.name,
                    path: '${AppRoutes.upgrade.route}:idx',
                    builder: (BuildContext context, GoRouterState state) {
                      return const UpgradePolicyScreen();
                    },
                  ),
                ]),
          ],
        ),
      ];
}
