// ignore: unused_import
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppUser extends StateNotifier<User?> {
  AppUser({required this.auth}) : super(null);

  final FirebaseAuth auth;

  Future<User?> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
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
