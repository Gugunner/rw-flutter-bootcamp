// ignore: unused_import
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:accesible_insurance_capstone_project/universal_app/utils/observers/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppUser extends StateNotifier<User?> {
  AppUser({required this.auth}) : super(null);

  final FirebaseAuth auth;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );

  //TODO: Check why sign in works once
  Future<User?> signInWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      final googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final userCredential = await auth.signInWithCredential(credential);
      state = userCredential.user;
      return state;
    } catch (e) {
      if (e is FirebaseAuthException) {
        rethrow;
      }
    }
    return null;
  }

  Future<void> signOutFromGoogle() async {
    try {
      if (_googleSignIn.currentUser != null) {
        _googleSignIn.signOut();
        await _googleSignIn.disconnect();
      }
    } catch (e) {
      print('failed to disconnect on signout');
    }
    try {
      await auth.signOut(); // which is basically firebase auth signout
    } catch (e) {
      print('failed to sign out');
    }
  }

  Future<User?> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = userCredential.user;
      return state;
    } catch (e) {
      if (e is FirebaseAuthException) {
        rethrow;
      }
    }
    return null;
  }

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = userCredential.user;
      return state;
    } catch (e) {
      if (e is FirebaseAuthException) {
        rethrow;
      }
    }
    return null;
  }
}
