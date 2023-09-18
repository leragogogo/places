import 'package:flutter/material.dart';
import 'package:places/data/model/filter_item.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_strings.dart';

class FilterRepository {
  List<FilterItem> candidateFilterItems = [
    FilterItem(
      name: AppStrings.hotelCategoryText,
      type: 'hotel',
      assetPath: AppAssets.hotelAsset,
      isSelected: true,
      index: 0,
    ),
    FilterItem(
      name: AppStrings.restaurantCategoryText,
      type: 'restaurant',
      assetPath: AppAssets.restarauntAsset,
      isSelected: true,
      index: 1,
    ),
    FilterItem(
      name: AppStrings.specialPlaceCategoryText,
      type: 'other',
      assetPath: AppAssets.specialPlaceAsset,
      isSelected: true,
      index: 2,
    ),
    FilterItem(
      name: AppStrings.parkCategoryText,
      type: 'park',
      assetPath: AppAssets.parkAsset,
      isSelected: true,
      index: 3,
    ),
    FilterItem(
      name: AppStrings.museumCategoryText,
      type: 'museum',
      assetPath: AppAssets.museumAsset,
      isSelected: true,
      index: 4,
    ),
    FilterItem(
      name: AppStrings.cafeCategoryText,
      type: 'cafe',
      assetPath: AppAssets.cafeAsset,
      isSelected: true,
      index: 5,
    ),
  ];

  RangeValues candidateRadius = const RangeValues(1, 10);

  List<FilterItem> activeFilterItems = [
    FilterItem(
      name: AppStrings.hotelCategoryText,
      type: 'hotel',
      assetPath: AppAssets.hotelAsset,
      isSelected: true,
      index: 0,
    ),
    FilterItem(
      name: AppStrings.restaurantCategoryText,
      type: 'restaurant',
      assetPath: AppAssets.restarauntAsset,
      isSelected: true,
      index: 1,
    ),
    FilterItem(
      name: AppStrings.specialPlaceCategoryText,
      type: 'other',
      assetPath: AppAssets.specialPlaceAsset,
      isSelected: true,
      index: 2,
    ),
    FilterItem(
      name: AppStrings.parkCategoryText,
      type: 'park',
      assetPath: AppAssets.parkAsset,
      isSelected: true,
      index: 3,
    ),
    FilterItem(
      name: AppStrings.museumCategoryText,
      type: 'museum',
      assetPath: AppAssets.museumAsset,
      isSelected: true,
      index: 4,
    ),
    FilterItem(
      name: AppStrings.cafeCategoryText,
      type: 'cafe',
      assetPath: AppAssets.cafeAsset,
      isSelected: true,
      index: 5,
    ),
  ];

  RangeValues activeRadius = const RangeValues(1, 10);
}
