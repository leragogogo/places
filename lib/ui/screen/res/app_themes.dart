import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_styles.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.ltUnselectedTabColor,
    primaryColorLight: AppColors.ltBackgroundColor,
    primaryColorDark: AppColors.ltTextColor,
    backgroundColor: AppColors.ltTitleColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.ltBackgroundColor,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.black,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    scaffoldBackgroundColor: AppColors.ltBackgroundColor,
    appBarTheme: AppBarTheme(
      color: AppColors.ltBackgroundColor,
      titleTextStyle: AppTypography.ltTitleFavouriteTextStyle,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.dtUnselectedTabColor,
    primaryColorLight: AppColors.dtLabelColor,
    primaryColorDark: AppColors.dtUnselectedLabelColor,
    backgroundColor: AppColors.ltBackgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.dtBackgroundColor,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    scaffoldBackgroundColor: AppColors.dtBackgroundColor,
    appBarTheme: AppBarTheme(
      color: AppColors.dtBackgroundColor,
      titleTextStyle: AppTypography.dtTitleFavouriteTextStyle,
    ),
  );
}
