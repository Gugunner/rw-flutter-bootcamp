import 'package:accesible_insurance_capstone_project/universal_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
      primarySwatch: AppColors.primarySwatchColor,
      primaryColor: AppColors.primarySwatchColor,
      backgroundColor: AppColors.backgroundColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      iconTheme:
          const IconThemeData().copyWith(color: AppColors.primaryIconColor),
      cardTheme: const CardTheme().copyWith(
        color: Colors.white,
        shadowColor: AppColors.primarySwatchColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          side: BorderSide(
            color: AppColors.primarySwatchColor,
          ),
        ),
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
          fontSize: 12,
          fontWeight: FontWeight.w600,
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
        primarySwatch: AppColors.primarySwatchColor,
        primaryColor: AppColors.primarySwatchColor,
        backgroundColor: AppColors.darkBackGroundColor,
        scaffoldBackgroundColor: AppColors.darkBackGroundColor,
        iconTheme:
            const IconThemeData().copyWith(color: AppColors.primaryIconColor),
        cardTheme: const CardTheme().copyWith(
          color: AppColors.primarySwatchColor,
          shadowColor: AppColors.primarySwatchColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
              color: Colors.white,
            ),
          ),
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
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          displayLarge: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
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
            fontSize: 12,
            fontWeight: FontWeight.w600,
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
        ),
      );
}
