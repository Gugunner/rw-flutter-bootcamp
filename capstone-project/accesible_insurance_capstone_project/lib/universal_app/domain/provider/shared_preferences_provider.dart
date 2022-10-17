import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  final tokenKey = 'idToken';
  final onboardingKey = 'onboarding';
  final signedInKey = 'signedIn';

  late SharedPreferences preferences;

  Future<void> setupSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  static final instance = SharedPreferencesProvider();

//App flags to know state of sign in and register process
  bool isOnboarding() {
    return preferences.getBool(onboardingKey) ?? true;
  }

  Future<void> setIsOnboarding(bool value) async {
    await preferences.setBool(onboardingKey, value);
  }

  bool isSignedIn() {
    return preferences.getBool(signedInKey) ?? false;
  }

  Future<void> setIsSignedIn(bool value) async {
    await preferences.setBool(signedInKey, value);
  }

  String restoreIdToken() {
    return preferences.getString(tokenKey) ?? '';
  }

  Future<void> saveIdToken(String token) async {
    await preferences.setString(tokenKey, token);
  }
}
