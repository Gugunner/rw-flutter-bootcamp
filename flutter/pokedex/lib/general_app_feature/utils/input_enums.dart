enum MessageType {
  unchecked,
  emptyEmail,
  emptyPassword,
  shortPassword,
  invalidEmail,
  invalidPassword,
  valid,
}

extension Messages on MessageType {
  String? get errorMessage {
    switch (this) {
      case MessageType.emptyEmail:
        return 'Please enter an email address';
      case MessageType.invalidEmail:
        return 'Please provide a valid email address';
      case MessageType.emptyPassword:
        return 'Please enter a password';
      case MessageType.shortPassword:
        return 'Minimum 6 characters for the password';
      case MessageType.invalidPassword:
        return 'Please provide a valid password';
      default:
        return null;
    }
  }
}

enum InputField {
  password,
  email,
}
