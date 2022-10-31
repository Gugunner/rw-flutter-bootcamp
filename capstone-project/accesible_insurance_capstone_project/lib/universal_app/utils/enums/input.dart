import 'package:accesible_insurance_capstone_project/universal_app/utils/copies/english_copies.dart';

enum InputErrorState {
  idle,
  emptyPassword,
  invalidPassword,
  passwordLength,
  emptyEmail,
  invalidEmail,
  userNotFound,
  wrongCredentials,
  emailInUse,
  notAllowed,
  weakPassword,
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
      case InputErrorState.userNotFound:
        return EnglishCopies.userNotFound;
      case InputErrorState.wrongCredentials:
        return EnglishCopies.wrongCredentials;
      case InputErrorState.emailInUse:
        return EnglishCopies.emailInUse;
      case InputErrorState.notAllowed:
        return EnglishCopies.notAllowed;
      case InputErrorState.weakPassword:
        return EnglishCopies.weakPassword;
      default:
        return null;
    }
  }
}

enum InputType {
  password,
  email,
}
