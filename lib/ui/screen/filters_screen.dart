import 'package:flutter/material.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/utils/filter_utils.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String distance = 'от 100 до 10000 м';

  Map<Categories, bool> statesOfCategories = {
    Categories.hotel: false,
    Categories.restaurant: false,
    Categories.specialPlace: false,
    Categories.park: false,
    Categories.museum: false,
    Categories.cafe: false,
  };

  RangeValues curValues = const RangeValues(100, 10000);

  int sightCount = mocks.length;

  bool isButtonDisabled = false;

  Location userLocation = Location(45, 44);

  Map<String, Categories> locationOfCategories = {
    '00': Categories.hotel,
    '01': Categories.restaurant,
    '02': Categories.specialPlace,
    '10': Categories.park,
    '11': Categories.museum,
    '12': Categories.cafe,
  };
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    sightCount = Provider.of<FiltersProvider>(context).sightCount;
    isButtonDisabled = Provider.of<FiltersProvider>(context).isButtonDisabled;

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
                sightCount = mocks.length;
                isButtonDisabled = false;
                curValues = const RangeValues(100, 10000);
              });
              Provider.of<FiltersProvider>(context, listen: false)
                  .changeState(sightCount, isButtonDisabled);
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
          CategoryButtonsRows(
            sightCount,
            userLocation,
            curValues,
            isButtonDisabled,
            locationOfCategories,
            statesOfCategories,
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
                      .where((element) => FilterUtils.isPointInArea(
                            userLocation,
                            Location(element.lat, element.lon),
                            curValues.start,
                            curValues.end,
                            statesOfCategories,
                            element.type,
                          ))
                      .length;
                  isButtonDisabled = sightCount == 0 ? true : false;
                });
                Provider.of<FiltersProvider>(context, listen: false)
                    .changeState(sightCount, isButtonDisabled);
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
}

// ignore: must_be_immutable
class CategoryButtonsRow extends StatefulWidget {
  final Location userLocation;
  final RangeValues curValues;
  final Map<String, Categories> locationOfCategories;
  final int numberOfRow;
  final Map<Categories, bool> statesOfCategories;
  bool isButtonDisabled;
  int sightCount;
  CategoryButtonsRow(
    this.sightCount,
    this.userLocation,
    this.curValues,
    this.isButtonDisabled,
    this.locationOfCategories,
    this.numberOfRow,
    this.statesOfCategories, {
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryButtonsRow> createState() => _CategoryButtonsRowState();
}

class _CategoryButtonsRowState extends State<CategoryButtonsRow> {
  @override
  Widget build(BuildContext context) {
    final row = <Widget>[];
    for (var i = 0; i < 3; i++) {
      final category = widget
          .locationOfCategories[widget.numberOfRow.toString() + i.toString()]!;
      row.add(CategoryButton(
        category,
        widget.statesOfCategories[category]!,
        () {
          setState(
            () {
              widget.statesOfCategories[category] =
                  !widget.statesOfCategories[category]!;
              widget
                ..sightCount = mocks
                    .where((element) => FilterUtils.isPointInArea(
                          widget.userLocation,
                          Location(element.lat, element.lon),
                          widget.curValues.start,
                          widget.curValues.end,
                          widget.statesOfCategories,
                          element.type,
                        ))
                    .length
                ..isButtonDisabled = widget.sightCount == 0 ? true : false;
            },
          );
          Provider.of<FiltersProvider>(context, listen: false)
              .changeState(widget.sightCount, widget.isButtonDisabled);
        },
      ));
    }

    return Row(
      children: row,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }
}

// ignore: must_be_immutable
class CategoryButtonsRows extends StatefulWidget {
  final Location userLocation;
  final RangeValues curValues;
  final bool isButtonDisabled;
  final Map<String, Categories> locationOfCategories;
  final Map<Categories, bool> statesOfCategories;
  int sightCount;
  CategoryButtonsRows(
    this.sightCount,
    this.userLocation,
    this.curValues,
    this.isButtonDisabled,
    this.locationOfCategories,
    this.statesOfCategories, {
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryButtonsRows> createState() => _CategoryButtonsRowsState();
}

class _CategoryButtonsRowsState extends State<CategoryButtonsRows> {
  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    for (var i = 0; i < 2; i++) {
      widgets.add(
        CategoryButtonsRow(
          widget.sightCount,
          widget.userLocation,
          widget.curValues,
          widget.isButtonDisabled,
          widget.locationOfCategories,
          i,
          widget.statesOfCategories,
        ),
      );
      if (i < 1) {
        widgets.add(const SizedBox(
          height: 40,
        ));
      }
    }

    return Column(
      children: widgets,
    );
  }
}

class FiltersProvider extends ChangeNotifier {
  int sightCount = 3;
  bool isButtonDisabled = false;
  void changeState(int newSightCount, bool newIsButtonDisabled) {
    sightCount = newSightCount;
    isButtonDisabled = newIsButtonDisabled;
    notifyListeners();
  }
}

class CategoryButton extends StatelessWidget {
  final Categories name;
  final bool isChosen;
  final VoidCallback? onPressed;

  const CategoryButton(
    this.name,
    this.isChosen,
    this.onPressed, {
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
              maxLines: 1,
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
