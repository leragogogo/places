import 'package:flutter/material.dart';
import 'package:places/data_providers/filter_provider.dart';
import 'package:places/domain/categories.dart';
import 'package:places/domain/location.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/utils/filter_utils.dart';
import 'package:provider/provider.dart';

// соответсвие между значениями слайдера и длиной радиуса поиска в метрах
Map<int, double> _points = {
  1: 100,
  2: 500,
  3: 1000,
  4: 2000,
  5: 3000,
  6: 4000,
  7: 5000,
  8: 6000,
  9: 7500,
  10: 10000,
};

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String distance = 'от 100 до 10000 м';

  // состояние кажой категории(выбрана или нет)
  Map<Categories, bool> statesOfCategories = {
    Categories.hotel: false,
    Categories.restaurant: false,
    Categories.specialPlace: false,
    Categories.park: false,
    Categories.museum: false,
    Categories.cafe: false,
  };

  // текущие значения слайдера
  RangeValues curValues = const RangeValues(1, 10);

  // количество подходящих под критерии мест
  int sightCount = 0;

  // состояние кнопки "ПОКАЗАТЬ"
  bool isButtonDisabled = true;

  Location userLocation = Location(lat: 45, lon: 44);

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
            debugPrint('Кнопка назад нажата');
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (final key in statesOfCategories.keys) {
                  statesOfCategories[key] = false;
                }
                sightCount = 0;
                isButtonDisabled = true;
                curValues = const RangeValues(1, 10);
                distance = 'от 100 до 10000 м';
              });
              Provider.of<FiltersProvider>(context, listen: false).changeState(
                newSightCount: sightCount,
                newIsButtonDisabled: isButtonDisabled,
              );
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
          Padding(
            padding: const EdgeInsets.only(left: 41, right: 41),
            child: SizedBox(
              width: double.infinity,
              child: _Categories(
                userLocation: userLocation,
                curValues: curValues,
                statesOfCategories: statesOfCategories,
              ),
            ),
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
                      'от ${_points[curValues.start.round()]?.toInt()} до ${_points[curValues.end.round()]?.toInt()} м';
                  sightCount = mocks
                      .where((element) => FilterUtils.isPointInArea(
                            point: userLocation,
                            center:
                                Location(lat: element.lat, lon: element.lon),
                            radius: RangeValues(
                              _points[curValues.start.round()]!,
                              _points[curValues.end.round()]!,
                            ),
                            stateOfCategory: statesOfCategories[element.type]!,
                          ))
                      .length;
                  isButtonDisabled = sightCount == 0;
                });
                Provider.of<FiltersProvider>(context, listen: false)
                    .changeState(
                  newSightCount: sightCount,
                  newIsButtonDisabled: isButtonDisabled,
                );
              },
              min: 1,
              max: 10,
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

// отрисовка всех категорий
class _Categories extends StatefulWidget {
  final Location userLocation;
  final RangeValues curValues;
  final Map<Categories, bool> statesOfCategories;

  const _Categories({
    required this.userLocation,
    required this.curValues,
    required this.statesOfCategories,
    Key? key,
  }) : super(key: key);

  @override
  State<_Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<_Categories> {
  bool isButtonDisabled = true;
  int sightCount = 0;
  @override
  Widget build(BuildContext context) {
    final row = <Widget>[];
    for (final category in Categories.values) {
      row.add(
        _CategoryButton(
          name: category,
          isChosen: widget.statesOfCategories[category]!,
          onPressed: () {
            setState(
              () {
                widget.statesOfCategories[category] =
                    !widget.statesOfCategories[category]!;
                sightCount = mocks
                    .where((element) => FilterUtils.isPointInArea(
                          point: widget.userLocation,
                          center: Location(lat: element.lat, lon: element.lon),
                          radius: RangeValues(
                            _points[widget.curValues.start.round()]!,
                            _points[widget.curValues.end.round()]!,
                          ),
                          stateOfCategory:
                              widget.statesOfCategories[element.type]!,
                        ))
                    .length;
                isButtonDisabled = sightCount == 0;
              },
            );
            Provider.of<FiltersProvider>(context, listen: false).changeState(
              newSightCount: sightCount,
              newIsButtonDisabled: isButtonDisabled,
            );
          },
        ),
      );
    }

    return Wrap(
      runSpacing: 40,
      alignment: WrapAlignment.spaceBetween,
      children: row,
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Categories name;
  final bool isChosen;
  final VoidCallback? onPressed;

  const _CategoryButton({
    required this.name,
    required this.isChosen,
    required this.onPressed,
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
                        name.pathToImage,
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
              name.name,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.backgroundColor),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}
