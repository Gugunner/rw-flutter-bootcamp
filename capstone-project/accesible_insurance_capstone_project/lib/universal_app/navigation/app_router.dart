import 'package:accesible_insurance_capstone_project/master_policies/ui/master_policy_list_screen.dart';
import 'package:accesible_insurance_capstone_project/policy_store/ui/store_screen.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/onboarding_screen.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/sign_in_screen.dart';
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
    //Redirects to [signin] route only if user ahs not signed in
    if (!signIn) {
      return AppRoutes.signin.route;
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
        ),
        GoRoute(
          name: AppRoutes.store.name,
          path: AppRoutes.store.route,
          builder: (BuildContext context, GoRouterState state) {
            return const StoreScreen();
          },
        ),
      ];
}
