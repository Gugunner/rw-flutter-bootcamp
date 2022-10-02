import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/model/user.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/user_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/enums/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppProvider {
  static final instance = AppProvider();

  final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

  //TODO: Load from Shared Preferences when initializing
  final signIn = StateProvider<bool>((ref) => false);

  final firebaseAutProvider =
      Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

  final authStateChangesProvider = StreamProvider.autoDispose<User?>(
    (ref) =>
        ref.watch(AppProvider.instance.firebaseAutProvider).authStateChanges(),
  );

  final userProvider =
      StateNotifierProvider<UserProvider, UserCredential?>((ref) {
    return UserProvider(
      auth: ref.watch(
        AppProvider.instance.firebaseAutProvider,
      ),
    );
  });

  final signInProvider = Provider.family<void, UserModel>((ref, user) async {
    try {
      final userCredential = await ref
          .watch(AppProvider.instance.userProvider.notifier)
          .signInWithEmail(user.email, user.password);
      final signIn = ref.watch(AppProvider.instance.signIn.notifier).state =
          userCredential?.user != null &&
              userCredential!.user?.getIdToken() != null;
      if (signIn) {
        ref.read(routeProvider.notifier).state = AppRoutes.homePath;
      }
    } on FirebaseAuthException catch (e) {
      final inputProviderInstance = InputProvider.instance;
      if (e.code.contains('invalid-email')) {
        ref.read(inputProviderInstance.emailStateProvider.notifier).state =
            InputErrorState.invalidEmail;
      } else if (e.code.contains('user-not-found')) {
        ref.read(inputProviderInstance.emailStateProvider.notifier).state =
            InputErrorState.userNotFound;
      } else if (e.code.contains('wrong-password')) {
        ref.read(inputProviderInstance.emailStateProvider.notifier).state =
            InputErrorState.wrongCredentials;
        ref.read(inputProviderInstance.passwordStateProvider.notifier).state =
            InputErrorState.wrongCredentials;
      }
    }
  });

  final goRouterProvider = Provider<GoRouter>(
    (ref) {
      final router = AppRouter(ref);
      return GoRouter(
        debugLogDiagnostics: true,
        refreshListenable: router,
        redirect: router.redirect,
        errorPageBuilder: (context, state) {
          return MaterialPage(
            key: state.pageKey,
            child: Scaffold(
              body: Center(
                child: Text(
                  state.error.toString(),
                ),
              ),
            ),
          );
        },
        routes: router.routes,
      );
    },
  );
}
