import 'package:flutter/material.dart';
import 'package:places/data_providers/filter_provider.dart';
import 'package:places/domain/categories.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';
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

  // состояние каждой категории(выбрана или нет)
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

  // места подходящие под критерии
  List<Sight> mocksWithFilters = mocks;

  // состояние кнопки "ПОКАЗАТЬ"
  bool isButtonDisabled = true;

  Location userLocation = Location(lat: 45, lon: 44);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    sightCount = Provider.of<FiltersProvider>(context).sightCount;
    isButtonDisabled = Provider.of<FiltersProvider>(context).isButtonDisabled;
    mocksWithFilters = Provider.of<FiltersProvider>(context).mocksWithFilters;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.canvasColor,
          ),
          onPressed: () {
            Navigator.pop(context, mocks);
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
                mocksWithFilters = mocks;
              });
              Provider.of<FiltersProvider>(context, listen: false).changeState(
                newSightCount: sightCount,
                newIsButtonDisabled: isButtonDisabled,
                newMocksWithFilters: mocksWithFilters,
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
                      ?.copyWith(color: theme.canvasColor),
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
                  mocksWithFilters = mocks
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
                      .toList();
                  sightCount = mocksWithFilters.length;
                  isButtonDisabled = sightCount == 0;
                });
                Provider.of<FiltersProvider>(context, listen: false)
                    .changeState(
                  newSightCount: sightCount,
                  newIsButtonDisabled: isButtonDisabled,
                  newMocksWithFilters: mocksWithFilters,
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
            child: BottomButton(
              text: '${AppStrings.showButtonText} ($sightCount)',
              onPressed: isButtonDisabled
                  ? null
                  : () {
                      Navigator.pop(context, mocksWithFilters);
                    },
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
  List<Sight> mocksWithFilters = mocks;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 40,
      alignment: WrapAlignment.spaceBetween,
      children: Categories.values.map((category) {
        return _CategoryButton(
          name: category,
          isChosen: widget.statesOfCategories[category]!,
          onPressed: () {
            _onCategoryButtonPressed(category);
          },
        );
      }).toList(),
    );
  }

  void _onCategoryButtonPressed(Categories category) {
    setState(
      () {
        widget.statesOfCategories[category] =
            !widget.statesOfCategories[category]!;
        mocksWithFilters = mocks
            .where((element) => FilterUtils.isPointInArea(
                  point: widget.userLocation,
                  center: Location(lat: element.lat, lon: element.lon),
                  radius: RangeValues(
                    _points[widget.curValues.start.round()]!,
                    _points[widget.curValues.end.round()]!,
                  ),
                  stateOfCategory: widget.statesOfCategories[element.type]!,
                ))
            .toList();
        sightCount = mocksWithFilters.length;
        isButtonDisabled = sightCount == 0;
      },
    );
    Provider.of<FiltersProvider>(context, listen: false).changeState(
      newSightCount: sightCount,
      newIsButtonDisabled: isButtonDisabled,
      newMocksWithFilters: mocksWithFilters,
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
              style:
                  theme.textTheme.bodySmall?.copyWith(color: theme.canvasColor),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}
