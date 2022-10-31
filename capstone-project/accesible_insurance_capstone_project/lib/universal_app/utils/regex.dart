class Regex {
  static String email =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’\'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+";
  static String password =
      r"^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[.!#$%&’\'*+-/=?^_`{|}~])";
  static String passwordCapitalCase = r'^(?=.*[A-Z])';
  static String passwordLowerCase = r'^(?=.*[a-z])';
  static String passwordOneNumber = r'^(?=.*[0-9])';
  static String passwordSpecialCharacter = r"^(?=.*[.!#$%&’\'*+-/=?^_`{|}~])";
  static String passwordLength = r'.{8,}';

  static final passwordRegexRules = [
    Regex.passwordCapitalCase,
    Regex.passwordLowerCase,
    Regex.passwordOneNumber,
    Regex.passwordSpecialCharacter,
    Regex.passwordLength,
  ];
}
