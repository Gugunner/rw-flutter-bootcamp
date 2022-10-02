// ignore: unused_import
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/app_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<UserCredential?> {
  UserProvider({required this.auth}) : super(null);

  String? authToken;
  final FirebaseAuth auth;
  bool isAuthenticating = false;
  dynamic error;

  Future<UserCredential?> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      state = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return state;
    } catch (e) {
      if (e is FirebaseAuthException) {
        rethrow;
      }
    }
    return null;
  }
}
