import 'package:accesible_insurance_capstone_project/master_policies/ui/master_policy_list_screen.dart';
import 'package:accesible_insurance_capstone_project/sign_in/ui/sign_in_screen.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter router([String? initialLocation]) => GoRouter(
      initialLocation: initialLocation ?? AppRoutes.home.route,
      routes: [
        GoRoute(
          name: 'home',
          path: AppRoutes.home.route,
          builder: (BuildContext context, GoRouterState state) =>
              const MasterPolicyListScreen(),
        ),
        GoRoute(
          name: 'sign in',
          path: AppRoutes.signin.route,
          builder: (BuildContext context, GoRouterState state) =>
              const SignInScreen(),
        ),
      ],
    );
