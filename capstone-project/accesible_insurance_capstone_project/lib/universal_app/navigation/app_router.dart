import 'package:accesible_insurance_capstone_project/master_policies/ui/master_policy_list_screen.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/sign_in_screen.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appProviderInstance = AppProvider.instance;

final routeProvider = StateProvider<String>((ref) => '');

class AppRouter extends ChangeNotifier {
  final Ref ref;

  AppRouter(this.ref) {
    ref.listen(routeProvider, (previous, next) => notifyListeners());
  }

  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    final signIn = ref.read(appProviderInstance.signIn);
    final route = ref.read(routeProvider.state).state;
    if (!signIn) {
      if (state.location == '/signin') {
        return null;
      }
      return AppRoutes.signInPath;
    } else if (signIn) {
      if (state.location == route) {
        return null;
      }
      return AppRoutes.homePath;
    }
    return null;
  }

  List<GoRoute> get routes => [
        GoRoute(
          name: 'home',
          path: AppRoutes.homePath,
          builder: (BuildContext context, GoRouterState state) =>
              const MasterPolicyListScreen(),
        ),
        GoRoute(
          name: 'sign in',
          path: AppRoutes.signInPath,
          builder: (BuildContext context, GoRouterState state) =>
              const SignInScreen(),
        ),
      ];
}
