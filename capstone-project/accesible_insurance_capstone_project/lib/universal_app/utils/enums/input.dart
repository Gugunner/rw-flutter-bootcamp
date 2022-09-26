import 'package:accesible_insurance_capstone_project/universal_app/utils/copies/english_copies.dart';

enum InputErrorState {
  idle,
  emptyPassword,
  invalidPassword,
  passwordLength,
  emptyEmail,
  invalidEmail,
}

extension InputErrorStateMessage on InputErrorState {
  String? get errorText {
    switch (this) {
      case InputErrorState.emptyPassword:
        return EnglishCopies.emptyPasswordError;
      case InputErrorState.invalidPassword:
        return EnglishCopies.passwordError;
      case InputErrorState.passwordLength:
        return EnglishCopies.lengthPasswordError;
      case InputErrorState.emptyEmail:
        return EnglishCopies.emptyEmailError;
      case InputErrorState.invalidEmail:
        return EnglishCopies.emailError;
      default:
        return null;
    }
  }
}

enum InputType {
  password,
  email,
}