import 'package:accesible_insurance_capstone_project/sign_in/domain/provider/input_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/data/sqlite/database_helper.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/model/user.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_user.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/shared_preferences_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/navigation/app_router.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/enums/input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AppProvider {
  static final instance = AppProvider();

  final themeProvider = StateProvider<ThemeMode>(
    (ref) => SharedPreferencesProvider.instance.restoreTheme(),
  );

  final signIn = StateProvider<bool>(
    (ref) => SharedPreferencesProvider.instance.isSignedIn(),
  );

  final firebaseAuthProvider =
      // Provider<FirebaseAuth>((ref) => getIt<AppAuth>().auth);
      Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

  final authStateChangesProvider = StreamProvider<User?>(
    (ref) =>
        ref.watch(AppProvider.instance.firebaseAuthProvider).authStateChanges(),
  );

  final authTokenProvider = FutureProvider<String?>((ref) async {
    final user = ref.watch(AppProvider.instance.authStateChangesProvider);
    final userValue = user.asData?.value;
    final token = await userValue?.getIdToken();
    SharedPreferencesProvider.instance.saveIdToken(token ?? '');
    return token;
  });

  final userProvider = StateNotifierProvider<AppUser, User?>((ref) {
    return AppUser(
      auth: ref.watch(
        AppProvider.instance.firebaseAuthProvider,
      ),
    );
  });

  final googleSignOutProvider = Provider<void>((ref) async {
    try {
      await ref
          .read(AppProvider.instance.userProvider.notifier)
          .signOutFromGoogle();
    } catch (e) {
      debugPrint('Sign out error ${e.toString()}');
    }
  });

  final googleSignInProvider = Provider<void>((ref) async {
    try {
      final user = await ref
          .watch(AppProvider.instance.userProvider.notifier)
          .signInWithGoogle();
      final signInState = ref.read(AppProvider.instance.signIn.state);
      final idToken = await user?.getIdToken();
      if (!signInState.state) {
        signInState.state = ref
            .watch(AppProvider.instance.signIn.notifier)
            .state = idToken != null;
      }
      //If the user is able to sign in, the route changes to "Home" ('/')
      if (signInState.state) {
        await SharedPreferencesProvider.instance.saveIdToken(idToken ?? '');
        await SharedPreferencesProvider.instance.setIsSignedIn(
          signInState.state,
        );
        await SharedPreferencesProvider.instance.setIsOnboarding(true);
        //Initialize Sqlite database
        await DatabaseHelper.instance.database;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Google Sign in error - ${e.code}');
    } catch (e) {
      debugPrint('Error');
    }
  });

  //Makes all changes to depending providers when the user signs in
  final signInProvider =
      Provider.family<void, UserModel>((ref, userCredentials) async {
    try {
      //Signs the user in with an email and password
      final user = await ref
          .watch(AppProvider.instance.userProvider.notifier)
          .signInWithEmail(userCredentials.email, userCredentials.password);
      //Changes the state of the sign in when the user signIn provider
      //changes state
      final signInState = ref.read(AppProvider.instance.signIn.state);
      final idToken = await user?.getIdToken();
      if (!signInState.state) {
        signInState.state = ref
            .watch(AppProvider.instance.signIn.notifier)
            .state = idToken != null;
      }
      //If the user is able to sign in, the route changes to "Home" ('/')
      if (signInState.state) {
        await SharedPreferencesProvider.instance.saveIdToken(idToken ?? '');
        await SharedPreferencesProvider.instance.setIsSignedIn(
          signInState.state,
        );

        //Initialize Sqlite database
        await DatabaseHelper.instance.database;
      }
    } on FirebaseAuthException catch (e) {
      ///If an error occurs and since the app know that any possible error
      ///comes from the firebase sign in call it maps the corresponding
      ///InputErrorState to be shown to te user.
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

  final signUpProvider =
      Provider.family<void, UserModel>((ref, userCredential) async {
    try {
      ///Signs up with the email and password using firebase 
      final user = await ref
          .read(AppProvider.instance.userProvider.notifier)
          .signUpWithEmail(
            email: userCredential.email,
            password: userCredential.password,
          );
      if (user != null) {
        ///If a User is returned from Firebase it resets the onboarding process
        ///and signs in with the user credentials
        await SharedPreferencesProvider.instance.setIsOnboarding(true);
        ref.read(AppProvider.instance.signInProvider(userCredential));
      }
    } on FirebaseAuthException catch (e) {
      ///If an error occurs and since the app know that any possible error
      ///comes from the firebase sign in call it maps the corresponding
      ///InputErrorState to be shown to te user.
      final inputProviderInstance = InputProvider.instance;
      if (e.code.contains('email-already-in-use')) {
        ref.read(inputProviderInstance.emailStateProvider.notifier).state =
            InputErrorState.emailInUse;
      } else if (e.code.contains('invalid-email')) {
        ref.read(inputProviderInstance.emailStateProvider.notifier).state =
            InputErrorState.invalidEmail;
      } else if (e.code.contains('operation-not-allowed')) {
        ref.read(inputProviderInstance.emailStateProvider.notifier).state =
            InputErrorState.notAllowed;
      } else if (e.code.contains('weak-password')) {
        ref.read(inputProviderInstance.emailStateProvider.notifier).state =
            InputErrorState.weakPassword;
      } else {
        ref.read(inputProviderInstance.emailStateProvider.notifier).state =
            InputErrorState.notAllowed;
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
