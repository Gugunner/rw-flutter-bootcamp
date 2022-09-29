import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserModel {
  const UserModel({
    required this.password,
    required this.email,
  });

  final String password;
  final String email;
}


