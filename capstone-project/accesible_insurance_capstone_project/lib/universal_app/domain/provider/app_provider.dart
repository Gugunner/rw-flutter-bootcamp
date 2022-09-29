import 'package:accesible_insurance_capstone_project/universal_app/domain/model/user.dart';
import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppProvider {
  static final instance = AppProvider();

  final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

  //TODO: Load from Shared Preferences when initializing
  final signedInProvider = StateProvider<bool>((ref) => false);

  final firebaseAutProvider =
      Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

  final authStateChangesProvider = StreamProvider.autoDispose<User?>(
    (ref) =>
        ref.watch(AppProvider.instance.firebaseAutProvider).authStateChanges(),
  );

  final userProvider = StateNotifierProvider<UserProvider, UserCredential?>(
    (ref) => UserProvider(
      auth: ref.watch(
        AppProvider.instance.firebaseAutProvider,
      ),
    ),
  );
}
