import 'package:flutter/material.dart';

import 'package:places/ui/screen/res/app_colors.dart';

class AppTypography {
  static TextStyle? descriptionTextStyle = TextStyle(
    color: AppColors.ltTextColor,
    fontSize: 14,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  static TextStyle? nameTextStyle = TextStyle(
    color: AppColors.ltTitleColor,
    fontSize: 16,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  static TextStyle? buildRouteButtonTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontFamily: 'Roboto',
  );

  static TextStyle? titleTextStyle = TextStyle(
    color: AppColors.ltTitleColor,
    fontSize: 32,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  static TextStyle? ltTitleFavouriteTextStyle = TextStyle(
    color: AppColors.ltTitleColor,
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  static TextStyle? dtTitleFavouriteTextStyle = TextStyle(
    color: AppColors.dtTitleColor,
    fontSize: 18,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );
}
