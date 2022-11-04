import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
      primarySwatch: AppColors.primarySwatchColor,
      primaryColor: AppColors.primarySwatchColor,
      backgroundColor: AppColors.backgroundColor,
      errorColor: AppColors.errorColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      iconTheme:
          const IconThemeData().copyWith(color: AppColors.primaryIconColor),
      cardTheme: const CardTheme().copyWith(
        color: Colors.white,
        elevation: 2,
        shadowColor: AppColors.primarySwatchColor,
        surfaceTintColor: AppColors.primarySwatchColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
        elevation: 4,
        selectedItemColor: AppColors.primaryColor,
        selectedIconTheme: IconThemeData().copyWith(
          color: AppColors.primaryColor,
        ),
      ),
      primaryIconTheme: IconThemeData().copyWith(
        color: AppColors.primaryColor,
      ),
      textTheme: const TextTheme().copyWith(
        bodySmall: const TextStyle(
          fontSize: 8,
          color: Colors.black,
        ),
        bodyMedium: const TextStyle(
          fontSize: 10,
          color: Colors.black,
        ),
        bodyLarge: const TextStyle(
          fontSize: 11,
          color: Colors.black,
        ),
        displaySmall: const TextStyle(
          fontSize: 8,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        displayMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        displayLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        labelSmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        labelMedium: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        labelLarge: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        headlineSmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        headlineMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
        headlineLarge: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        titleSmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        titleMedium: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
        titleLarge: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ));

  static ThemeData get darkTheme => ThemeData(
        primarySwatch: AppColors.darkPrimarySwatchColor,
        primaryColor: AppColors.darkPrimaryColor,
        backgroundColor: AppColors.darkBackGroundColor,
        errorColor: AppColors.errorColor,
        scaffoldBackgroundColor: AppColors.darkBackGroundColor,
        iconTheme:
            const IconThemeData().copyWith(color: AppColors.primaryIconColor),
        cardTheme: const CardTheme().copyWith(
          color: AppColors.darkPrimarySwatchColor,
          shadowColor: AppColors.darkPrimaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
          backgroundColor: Color.fromARGB(255, 11, 12, 26),
          unselectedItemColor: Colors.grey.shade400,
          selectedItemColor: AppColors.darkPrimaryColor,
          selectedIconTheme: IconThemeData().copyWith(
            color: AppColors.darkPrimaryColor,
          ),
        ),
        primaryIconTheme: IconThemeData().copyWith(
          color: AppColors.darkPrimaryColor,
        ),
        textTheme: const TextTheme().copyWith(
          bodySmall: const TextStyle(
            fontSize: 8,
            color: Colors.white,
          ),
          bodyMedium: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
          bodyLarge: const TextStyle(
            fontSize: 11,
            color: Colors.white,
          ),
          displaySmall: const TextStyle(
            fontSize: 8,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          displayMedium: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          displayLarge: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          labelSmall: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          labelMedium: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          labelLarge: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          headlineSmall: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          headlineMedium: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          headlineLarge: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          titleSmall: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          titleMedium: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          titleLarge: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      );
}
