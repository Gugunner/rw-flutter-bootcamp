import 'package:flutter/material.dart';

class AppColors {
  //***************Regular/light Theme colors****************/\
  static const primaryColor = Color(0xFF19235E);
  static const primarySwatchColor = MaterialColor(0xFF19235E, <int, Color>{
    50: Color(0xFF19235E),
    100: Color(0xFF19235E),
    200: Color(0xFF19235E),
    300: Color(0xFF19235E),
    400: Color(0xFF19235E),
    500: Color(0xFF19235E),
    600: Color(0xFF19235E),
    700: Color(0xFF19235E),
    800: Color(0xFF19235E),
    900: Color(0xFF19235E),
  });
  static const backgroundColor = Color(0XFFF2F3F7);
  static const scaffoldBackgroundColor = AppColors.backgroundColor;

  //***************Dark Theme colors****************/
  static const darkPrimaryColor = Color(0xFFBECBF7);
  static const darkPrimarySwatchColor = MaterialColor(0xFFBECBF7, <int, Color>{
    50: Color(0xFFBECBF7),
    100: Color(0xFFBECBF7),
    200: Color(0xFFBECBF7),
    300: Color(0xFFBECBF7),
    400: Color(0xFFBECBF7),
    500: Color(0xFFBECBF7),
    600: Color(0xFFBECBF7),
    700: Color(0xFFBECBF7),
    800: Color(0xFFBECBF7),
    900: Color(0xFFBECBF7),
  });
  static const darkBackGroundColor = Color(0xFF091545);
  static const darkScaffoldBackgroundColor = AppColors.darkBackGroundColor;
  static const primaryIconColor = Colors.white;

  //Shimmer linear gradien color for loading screens
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}
