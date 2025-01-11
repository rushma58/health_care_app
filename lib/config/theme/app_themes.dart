import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/text_styles.dart';

class AppThemes {
  static ThemeData get lightTheme => _lightTheme;

  // ** YOUR LIGHT/ DEFAULT THEME
  static final _lightTheme = ThemeData(
    fontFamily: AppConstants.poppins,
    scaffoldBackgroundColor: AppColors.appBg,
    appBarTheme: AppBarTheme(
      foregroundColor: AppColors.black,
      backgroundColor: AppColors.appBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyles.bold18.copyWith(
        color: AppColors.black,
      ),
      centerTitle: true,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.inputBorder,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppConstants.borderRadius),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.transparent,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppConstants.borderRadius),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppConstants.borderRadius),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.transparent,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppConstants.borderRadius),
        ),
      ),
      errorMaxLines: 2,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.appBg,
      surfaceTintColor: AppColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
  );
}
