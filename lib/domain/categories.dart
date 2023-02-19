import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_strings.dart';

enum Categories {
  hotel(
    AppStrings.hotelCategoryText,
    AppAssets.hotelAsset,
  ),
  restaurant(
    AppStrings.restaurantCategoryText,
    AppAssets.restarauntAsset,
  ),
  specialPlace(
    AppStrings.specialPlaceCategoryText,
    AppAssets.specialPlaceAsset,
  ),
  park(
    AppStrings.parkCategoryText,
    AppAssets.parkAsset,
  ),
  museum(
    AppStrings.museumCategoryText,
    AppAssets.museumAsset,
  ),
  cafe(
    AppStrings.cafeCategoryText,
    AppAssets.cafeAsset,
  ),
  ;

  const Categories(this.name, this.pathToImage);
  final String name;
  final String pathToImage;
}
