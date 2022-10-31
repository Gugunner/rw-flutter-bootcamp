import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_user.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/copies/english_copies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
// ignore: depend_on_referenced_packages
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  const fakeEmail = 'test@yopmail.com';
  const fakePassword = 'Test#1234';
  const uid = 'rquNKEPunYhcsK0o59SHuECM3al3';
  final mockUser = MockUser(
    isAnonymous: false,
    uid: uid,
    email: fakeEmail,
  );

  group('basic firebase auth tests', () {
    test('should return uid and idToken when authenticated by email', () async {
      final auth = MockFirebaseAuth(
        mockUser: mockUser,
      );
      final userCredential = await auth.signInWithEmailAndPassword(
        email: fakeEmail,
        password: fakePassword,
      );
      expect(userCredential.user, isNotNull);
      expect(userCredential.user!.uid, 'rquNKEPunYhcsK0o59SHuECM3al3');
      expect(await userCredential.user!.getIdToken(), isNotEmpty);
    });

    test(
        'should return error code wrong-password if firebase throws '
        'an exception', () async {
      const errorCode = 'wrong-password';
      const errorMessage = EnglishCopies.wrongCredentials;
      final auth = MockFirebaseAuth(
        mockUser: mockUser,
        authExceptions: AuthExceptions(
          signInWithEmailAndPassword: FirebaseAuthException(
            code: errorCode,
            message: errorMessage,
          ),
        ),
      );
      try {
        // ignore: unused_local_variable
        final userCredential = await auth.signInWithEmailAndPassword(
          email: fakeEmail,
          password: fakePassword,
        );
      } catch (e) {
        expect(e is FirebaseAuthException, true);
        expect((e as FirebaseAuthException).code, errorCode);
        expect((e).message, errorMessage);
      }
    });
  });

  group('sign in unit tests', () {
    test(
        'should return uid and idToken when authenticated user is '
        'authenticated by email', () async {
      final auth = MockFirebaseAuth(
        mockUser: mockUser,
      );
      final appUser = AppUser(auth: auth);
      final userCredential = await appUser.signInWithEmail(
        fakeEmail,
        fakePassword,
      );
      expect(userCredential, isNotNull);
      expect(userCredential, isNotNull);
      expect(userCredential?.uid, 'rquNKEPunYhcsK0o59SHuECM3al3');
      expect(await userCredential?.getIdToken(), isNotEmpty);
    });
  });

  test(
      'should return error code wrong-password if firebase throws an exception '
      'when authenticating user', () async {
    const errorCode = 'wrong-password';
    const errorMessage = EnglishCopies.wrongCredentials;
    final auth = MockFirebaseAuth(
      mockUser: mockUser,
      authExceptions: AuthExceptions(
        signInWithEmailAndPassword: FirebaseAuthException(
          code: errorCode,
          message: errorMessage,
        ),
      ),
    );
    final appUser = AppUser(auth: auth);
    try {
      // ignore: unused_local_variable
      final userCredential = await appUser.signInWithEmail(
        fakeEmail,
        fakePassword,
      );
    } catch (e) {
      expect(e is FirebaseAuthException, true);
      expect((e as FirebaseAuthException).code, errorCode);
      expect((e).message, errorMessage);
    }
  });
}

Future<GoogleSignInAccount?> getWith(
        {required MockGoogleSignIn mockGoogleSignIn}) async =>
    mockGoogleSignIn.signIn();
