import 'package:accesible_insurance_capstone_project/universal_app/domain/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AppAuth>(AppAuth(auth: FirebaseAuth.instance));
}