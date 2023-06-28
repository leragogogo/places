import 'package:flutter/material.dart';
import 'package:places/data/interactor/filter_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/filter_item.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data_providers/filter_provider.dart';
import 'package:places/domain/location.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';
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

Map<double, double> _fromRepository = {
  100: 1,
  500: 2,
  1000: 3,
  2000: 4,
  3000: 5,
  4000: 6,
  5000: 7,
  6000: 8,
  7500: 9,
  10000: 10,
};

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  String distance = 'от 100 до 10000 м';

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
            color: theme.canvasColor,
          ),
          onPressed: () {
            Navigator.pop(context, <dynamic>[]);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                Provider.of<FilterInteractor>(
                  context,
                  listen: false,
                ).clearActiveCategories();
                sightCount = 0;
                isButtonDisabled = true;
                Provider.of<FilterInteractor>(
                  context,
                  listen: false,
                ).candidateCurRadius = const RangeValues(100, 10000);
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
      body: LayoutBuilder(
        builder: (context, constraint) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 32),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppStrings.categoryText,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.primaryColorDark,
                          fontSize: 12,
                        ),
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
                        radius: RangeValues(
                          Provider.of<FilterInteractor>(
                            context,
                            listen: false,
                          ).candidateCurRadius.start,
                          Provider.of<FilterInteractor>(
                            context,
                            listen: false,
                          ).candidateCurRadius.end,
                        ),
                        userLocation: userLocation,
                        filterItems: Provider.of<FilterInteractor>(
                          context,
                          listen: false,
                        ).candidateFilterItems,
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
                      values: RangeValues(
                        _fromRepository[Provider.of<FilterInteractor>(
                          context,
                          listen: false,
                        ).candidateCurRadius.start]!,
                        _fromRepository[Provider.of<FilterInteractor>(
                          context,
                          listen: false,
                        ).candidateCurRadius.end]!,
                      ),
                      onChanged: (values) {
                        setState(() {
                          Provider.of<FilterInteractor>(
                            context,
                            listen: false,
                          ).candidateCurRadius = RangeValues(
                            _points[values.start]!,
                            _points[values.end]!,
                          );
                          distance = 'от ${Provider.of<FilterInteractor>(
                            context,
                            listen: false,
                          ).candidateCurRadius.start.round().toInt()} до ${Provider.of<FilterInteractor>(
                            context,
                            listen: false,
                          ).candidateCurRadius.end.round().toInt()} м';

                          sightCount = Provider.of<PlaceInteractor>(
                            context,
                            listen: false,
                          )
                              .getPlaces(
                                radius: RangeValues(
                                  Provider.of<FilterInteractor>(
                                    context,
                                    listen: false,
                                  ).candidateCurRadius.start,
                                  Provider.of<FilterInteractor>(
                                    context,
                                    listen: false,
                                  ).candidateCurRadius.end,
                                ),
                                categories: Provider.of<FilterInteractor>(
                                  context,
                                  listen: false,
                                ).getSelectedCandidateCategories(),
                              )
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
                    child: BottomButton(
                      text: '${AppStrings.showButtonText} ($sightCount)',
                      onPressed: isButtonDisabled
                          ? null
                          : () {
                              Provider.of<FilterInteractor>(
                                context,
                                listen: false,
                              ).candidateToActive();

                              Navigator.pop(context, <dynamic>[]);
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// отрисовка всех категорий
class _Categories extends StatefulWidget {
  final RangeValues radius;
  final Location userLocation;
  final List<FilterItem> filterItems;

  const _Categories({
    required this.userLocation,
    required this.filterItems,
    required this.radius,
    Key? key,
  }) : super(key: key);

  @override
  State<_Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<_Categories> {
  bool isButtonDisabled = true;
  int sightCount = 0;
  List<Place> filteredPlaces = [];
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 40,
      alignment: WrapAlignment.spaceBetween,
      children: Provider.of<FilterInteractor>(
        context,
        listen: false,
      ).candidateFilterItems.map((e) {
        return _CategoryButton(
          name: e,
          isChosen: e.isSelected,
          onPressed: () {
            _onCategoryButtonPressed(e.index);
          },
        );
      }).toList(),
    );
  }

  void _onCategoryButtonPressed(int index) {
    setState(
      () {
        Provider.of<FilterInteractor>(
          context,
          listen: false,
        ).changeStateOfCategory(index);

        sightCount = Provider.of<PlaceInteractor>(context, listen: false)
            .getPlaces(
              radius: widget.radius,
              categories: Provider.of<FilterInteractor>(
                context,
                listen: false,
              ).getSelectedCandidateCategories(),
            )
            .length;
        debugPrint(sightCount.toString());
        isButtonDisabled = sightCount == 0;
      },
    );
    Provider.of<FiltersProvider>(context, listen: false).changeState(
      newSightCount: sightCount,
      newIsButtonDisabled: isButtonDisabled,
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final FilterItem name;
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
                        name.assetPath,
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
