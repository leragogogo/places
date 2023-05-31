import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_styles.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    primaryColor: AppColors.ltUnselectedTabColor,
    primaryColorLight: AppColors.ltBackgroundColor,
    primaryColorDark: AppColors.ltTextColor,
    canvasColor: AppColors.ltTitleColor,
    textTheme: TextTheme(
      bodyLarge: AppTypography.titleTextStyle,
      bodyMedium: AppTypography.nameTextStyle,
      bodySmall: AppTypography.descriptionTextStyle,
    ),
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
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: AppColors.dtUnselectedTabColor,
    primaryColorLight: AppColors.dtLabelColor,
    primaryColorDark: AppColors.dtUnselectedLabelColor,
    canvasColor: AppColors.ltBackgroundColor,
    textTheme: TextTheme(
      bodyLarge: AppTypography.titleTextStyle,
      bodyMedium: AppTypography.nameTextStyle,
      bodySmall: AppTypography.descriptionTextStyle,
    ),
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
     bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
  );
}
