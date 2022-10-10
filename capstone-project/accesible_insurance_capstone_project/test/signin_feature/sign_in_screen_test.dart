import 'package:accesible_insurance_capstone_project/sign_in/utils/constants/widget_keys.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/shared_preferences_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/app_routes.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/enums/input.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/observers/logger.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
// ignore: depend_on_referenced_packages
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/extensions/widget_tester.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  await SharedPreferencesProvider.instance.setupSharedPreferences();
  const uid = 'rquNKEPunYhcsK0o59SHuECM3al3';
  const pid = 'qfrgafACPuaYdGnVVTaE';

  final firestoreInstance = FakeFirebaseFirestore();
  await firestoreInstance
      .collection('users')
      .doc(uid)
      .collection('master-policies')
      .doc(pid)
      .set(
    {
      'activeSince': 'October 2, 2022 at 11:11:04 AM UTC-5',
      'currentSI': 2089,
      'expires': 'April 19, 2023 at 5:15:50 PM UTC-5',
      'location': {
        'country': 'Mexico',
        'state': 'Jalisco',
        'city': 'Huentitan',
      },
      'name': "Mama's home in Jalisco",
      'policyId': 'AAA',
      'roomDescription': {
        'bathroom': 2,
        'bedroom': 2,
      },
      'status': 'active',
      'type': 'property',
    },
  );

  var fakeEmail = 'test@yopmail.com';
  var fakePassword = 'Test#1234';
  // const uid = 'rquNKEPunYhcsK0o59SHuECM3al3';
  final mockUser = MockUser(
    isAnonymous: false,
    uid: uid,
    email: fakeEmail,
  );
  final auth = MockFirebaseAuth(
    mockUser: mockUser,
  );

  // print(snapshot.docs.length);
  // print(snapshot.docs.first.id);
  // print(snapshot.docs.first.get('location'));
  // print(snapshot.docs.first.get('location')['country']);
  // print(snapshot.docs.first.get('activeSince'));
  // print(firestoreInstance.dump());

  final appProviderInstance = AppProvider.instance;

  group('go router tests', () {
    testWidgets('using pumpAppToRoute allows the single navigation of a route',
        (tester) async {
      final fakeFirebaseAuthProvider = Provider<FirebaseAuth>((ref) => auth);
      await tester.pumpAppToRoute(AppRoutes.signin.route, (child) => child,
          overrides: [fakeFirebaseAuthProvider]);

      final signInScreen = find.byKey(SigninWidgetKeys.screenKey);
      final passwordInput = find.byKey(SigninWidgetKeys.passwordInputKey);
      final emailInput = find.byKey(SigninWidgetKeys.emailInputKey);
      final loginButton = find.byKey(SigninWidgetKeys.signinButtonKey);

      expect(signInScreen, findsOneWidget);
      expect(emailInput, findsOneWidget);
      expect(passwordInput, findsOneWidget);
      expect(loginButton, findsOneWidget);
    });

    testWidgets(
        'using pumpRealAppRouter allows the test to be worked as a real app',
        (tester) async {
      final fakeFirebaseAuthProvider = Provider<FirebaseAuth>((ref) => auth);
      await tester.pumpRealAppRouter(
        observers: [Logger()],
        overrides: [
          appProviderInstance.firebaseAuthProvider
              .overrideWithProvider(fakeFirebaseAuthProvider),
        ],
      );
      await tester.pump(
        const Duration(seconds: 10),
      );

      final signInScreen = find.byKey(SigninWidgetKeys.screenKey);
      final passwordInput = find.byKey(SigninWidgetKeys.passwordInputKey);
      final emailInput = find.byKey(SigninWidgetKeys.emailInputKey);
      final loginButton = find.byKey(SigninWidgetKeys.signinButtonKey);

      expect(signInScreen, findsOneWidget);
      expect(emailInput, findsOneWidget);
      expect(passwordInput, findsOneWidget);
      expect(loginButton, findsOneWidget);

      fakePassword = '1';
      fakeEmail = '';

      expect(find.text('1'), findsNothing);
      await tester.enterText(emailInput, fakeEmail);
      await tester.enterText(passwordInput, fakePassword);
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });
  });

  group('sign in input tests', () {
    const errorColor = Color(0Xffd32f2f);
    final fakeFirebaseAuthProvider = Provider<FirebaseAuth>((ref) => auth);
    testWidgets(
        'when the user enters an empty email and/or an empty password, '
        'the inputs get a red border and empty error texts', (tester) async {
      //TODO: Add error color to ThemeApp
      await tester.pumpAppToRoute(AppRoutes.signin.route, (child) => child,
          overrides: [fakeFirebaseAuthProvider]);

      final signInScreen = find.byKey(SigninWidgetKeys.screenKey);
      final passwordInput = find.descendant(
        of: find.byKey(SigninWidgetKeys.passwordInputKey),
        matching: find.byType(TextField),
      );
      final emailInput = find.descendant(
        of: find.byKey(SigninWidgetKeys.emailInputKey),
        matching: find.byType(TextField),
      );
      final loginButton = find.byKey(SigninWidgetKeys.signinButtonKey);
      expect(signInScreen, findsOneWidget);
      expect(emailInput, findsOneWidget);
      expect(passwordInput, findsOneWidget);
      expect(loginButton, findsOneWidget);
      var emailBorderColor = tester
          .widget<TextField>(emailInput)
          .decoration
          ?.enabledBorder
          ?.borderSide
          .color;
      var emailInputError =
          tester.widget<TextField>(emailInput).decoration?.errorText;
      var passwordInputError =
          tester.widget<TextField>(passwordInput).decoration?.errorText;
      var passwordBorderColor = tester
          .widget<TextField>(emailInput)
          .decoration
          ?.enabledBorder
          ?.borderSide
          .color;
      expect(emailBorderColor, Colors.black);
      expect(passwordBorderColor, Colors.black);
      expect(emailInputError, InputErrorState.idle.errorText);
      expect(passwordInputError, InputErrorState.idle.errorText);
      await tester.tap(loginButton);
      await tester.pump();
      emailBorderColor = tester
          .widget<TextField>(emailInput)
          .decoration
          ?.enabledBorder
          ?.borderSide
          .color;
      passwordBorderColor = tester
          .widget<TextField>(emailInput)
          .decoration
          ?.enabledBorder
          ?.borderSide
          .color;
      emailInputError =
          tester.widget<TextField>(emailInput).decoration?.errorText;
      passwordInputError =
          tester.widget<TextField>(passwordInput).decoration?.errorText;
      expect(emailBorderColor, errorColor);
      expect(passwordBorderColor, errorColor);
      expect(emailInputError, InputErrorState.emptyEmail.errorText);
      expect(passwordInputError, InputErrorState.emptyPassword.errorText);
    });

    testWidgets(
        'when the user enters an invalid email and/or invalid password,'
        'the inputs get a red border and invalid errror texts', (tester) async {
      fakeEmail = 'test@';
      fakePassword = 'test12';
      await tester.pumpAppToRoute(AppRoutes.signin.route, (child) => child,
          overrides: [fakeFirebaseAuthProvider]);
      final passwordInput = find.descendant(
        of: find.byKey(SigninWidgetKeys.passwordInputKey),
        matching: find.byType(TextField),
      );
      final emailInput = find.descendant(
        of: find.byKey(SigninWidgetKeys.emailInputKey),
        matching: find.byType(TextField),
      );
      final loginButton = find.byKey(SigninWidgetKeys.signinButtonKey);
      var emailInputError =
          tester.widget<TextField>(emailInput).decoration?.errorText;
      var passwordInputError =
          tester.widget<TextField>(passwordInput).decoration?.errorText;
      expect(emailInputError, InputErrorState.idle.errorText);
      expect(passwordInputError, InputErrorState.idle.errorText);
      await tester.enterText(emailInput, fakeEmail);
      await tester.enterText(passwordInput, fakePassword);
      await tester.tap(loginButton);
      await tester.pump();
      final emailBorderColor = tester
          .widget<TextField>(emailInput)
          .decoration
          ?.enabledBorder
          ?.borderSide
          .color;
      final passwordBorderColor = tester
          .widget<TextField>(emailInput)
          .decoration
          ?.enabledBorder
          ?.borderSide
          .color;
      emailInputError =
          tester.widget<TextField>(emailInput).decoration?.errorText;
      passwordInputError =
          tester.widget<TextField>(passwordInput).decoration?.errorText;
      expect(emailBorderColor, errorColor);
      expect(passwordBorderColor, errorColor);
      expect(emailInputError, InputErrorState.invalidEmail.errorText);
      expect(passwordInputError, InputErrorState.invalidPassword.errorText);
    });

    testWidgets(
        'when the user enters a correct valid email and coreect valid password,'
        'the user signs in and is redirected to the '
        'master policies list screen',
        (tester) async {});
  });
}

Future<GoogleSignInAccount?> getWith(
        {required MockGoogleSignIn mockGoogleSignIn}) async =>
    mockGoogleSignIn.signIn();
