import 'package:flutter/material.dart';
import 'package:places/domain/location.dart';
import 'package:places/functions.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';

enum Categories { hotel, restaurant, specialPlace, park, museum, cafe }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Map<Categories, bool> statesOfCategories = {
    Categories.hotel: false,
    Categories.restaurant: false,
    Categories.specialPlace: false,
    Categories.park: false,
    Categories.museum: false,
    Categories.cafe: false,
  };

  String distance = 'от 500 до 3000 м';
  RangeValues curValues = const RangeValues(500, 3000);
  Location userLocation = Location(45, 44);
  int sightCount = mocks.length;
  Map<int, int> points = {
    100: 100,
    1200: 500,
    2300: 1000,
    3399: 2000,
    4500: 3000,
    5600: 4000,
    6699: 5000,
    7800: 6000,
    8900: 7500,
    10000: 10000,
  };
  bool isButtonDisabled = false;
  Map<String, Categories> locationOfCategories = {
    '00': Categories.hotel,
    '01': Categories.restaurant,
    '02': Categories.specialPlace,
    '10': Categories.park,
    '11': Categories.museum,
    '12': Categories.cafe,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.backgroundColor,
          ),
          onPressed: () {
            // ignore: avoid_print
            print('Кнопка назад нажата');
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (final key in statesOfCategories.keys) {
                  statesOfCategories[key] = false;
                }
              });
            },
            child: Text(
              AppStrings.cleanButtonText,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.planButtonColor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 32),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                AppStrings.categoryText,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.primaryColorDark, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Column(
            children: categoryButtonsRows(),
          ),
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Text(
                  AppStrings.distanceText,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.backgroundColor),
                ),
                Text(
                  distance,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.primaryColorDark),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SliderTheme(
            data: const SliderThemeData(
              trackHeight: 1,
            ),
            child: RangeSlider(
              values: curValues,
              onChanged: (values) {
                setState(() {
                  curValues = values;
                  distance =
                      'от ${points[values.start.toInt()]} до ${points[values.end.toInt()]} м';
                  sightCount = mocks
                      .where((element) => Functions.isPointInArea(
                            userLocation,
                            Location(element.lat, element.lon),
                            curValues.start,
                            curValues.end,
                          ))
                      .length;
                  isButtonDisabled = sightCount == 0 ? true : false;
                });
              },
              min: 100,
              max: 10000,
              activeColor: AppColors.planButtonColor,
              inactiveColor: AppColors.ltTextColor,
              divisions: 9,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.planButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: isButtonDisabled ? null : () {},
                    child: Center(
                      child: Text(
                        'ПОКАЗАТЬ ($sightCount)',
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> categoryButtonsRow(int numberOfRow) {
    final row = <Widget>[];
    for (var i = 0; i < 3; i++) {
      final category =
          locationOfCategories[numberOfRow.toString() + i.toString()]!;
      row.add(CategoryButton(
        category,
        statesOfCategories[category]!,
        () {
          setState(() {
            statesOfCategories[category] = !statesOfCategories[category]!;
          });
        },
        (value) {
          statesOfCategories[category] = value;
        },
      ));
    }

    return row;
  }

  List<Widget> categoryButtonsRows() {
    final widgets = <Widget>[];
    for (var i = 0; i < 2; i++) {
      widgets.add(
        Row(
          children: categoryButtonsRow(i),
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      );
      if (i < 1) {
        widgets.add(const SizedBox(
          height: 40,
        ));
      }
    }

    return widgets;
  }
}

class CategoryButton extends StatelessWidget {
  final Categories name;
  final bool isChosen;
  final VoidCallback? onPressed;
  final Function(bool)? onChanged;
  const CategoryButton(
    this.name,
    this.isChosen,
    this.onPressed,
    this.onChanged, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Ink(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.categoriesColor,
            shape: BoxShape.circle,
          ),
          child: InkWell(
            child: Stack(
              children: [
                Center(
                  child: IconButton(
                    icon: ImageIcon(
                      AssetImage(
                        pathToImage(),
                      ),
                      color: AppColors.planButtonColor,
                    ),
                    onPressed: onPressed,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: isChosen
                      ? const Icon(
                          Icons.check_circle,
                          size: 20.0,
                          color: Colors.black,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          width: 96,
          child: Center(
            child: Text(
              title(),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.backgroundColor),
            ),
          ),
        ),
      ],
    );
  }

  String pathToImage() {
    switch (name) {
      case Categories.hotel:
        return 'res/icons/hotels.png';
      case Categories.restaurant:
        return 'res/icons/restaurants.png';
      case Categories.specialPlace:
        return 'res/icons/special_places.png';
      case Categories.park:
        return 'res/icons/parks.png';
      case Categories.museum:
        return 'res/icons/museums.png';
      case Categories.cafe:
        return 'res/icons/cafes.png';
    }
  }

  String title() {
    switch (name) {
      case Categories.hotel:
        return AppStrings.hotelCategoryText;
      case Categories.restaurant:
        return AppStrings.restaurantCategoryText;
      case Categories.specialPlace:
        return AppStrings.specialPlaceCategoryText;
      case Categories.park:
        return AppStrings.parkCategoryText;
      case Categories.museum:
        return AppStrings.museumCategoryText;
      case Categories.cafe:
        return AppStrings.cafeCategoryText;
    }
  }
}
