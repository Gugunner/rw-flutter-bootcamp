import 'package:flutter/material.dart';

class AppColors {
  //***************Regular/light Theme colors****************/\
  static const primaryColor = Color(0xFF4B59C0);
  static const primarySwatchColor = MaterialColor(0xFF4B59C0, <int, Color>{
    50: Color(0xFF4B59C0),
    100: Color(0xFF4B59C0),
    200: Color(0xFF4B59C0),
    300: Color(0xFF4B59C0),
    400: Color(0xFF4B59C0),
    500: Color(0xFF4B59C0),
    600: Color(0xFF4B59C0),
    700: Color(0xFF4B59C0),
    800: Color(0xFF4B59C0),
    900: Color(0xFF4B59C0),
  });
  static const backgroundColor = Color(0XFFF2F3F7);
  static const errorColor = Color(0xffdb5858);
  static const correctColor = Colors.green;
  static const scaffoldBackgroundColor = AppColors.backgroundColor;

  //***************Dark Theme colors****************/
  static const darkPrimaryColor = Color(0xFF5E60DD);
  static const darkPrimarySwatchColor = MaterialColor(0xFF5E60DD, <int, Color>{
    50: Color(0xFF5E60DD),
    100: Color(0xFF5E60DD),
    200: Color(0xFF5E60DD),
    300: Color(0xFF5E60DD),
    400: Color(0xFF5E60DD),
    500: Color(0xFF5E60DD),
    600: Color(0xFF5E60DD),
    700: Color(0xFF5E60DD),
    800: Color(0xFF5E60DD),
    900: Color(0xFF5E60DD),
  });
  static const darkBackGroundColor = Colors.black;
  static const darkCorrectColor = Colors.green;
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
