class Regex {
  static String email =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’\'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+";
  static String password =
      r"^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[.!#$%&’\'*+-/=?^_`{|}~])";
}
