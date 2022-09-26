import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppProvider {
  static final instance = AppProvider();

  final themeProvider =
      StateProvider<ThemeMode>((ref) => ThemeMode.light);

}
