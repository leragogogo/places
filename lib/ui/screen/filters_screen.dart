import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/model/filter_item.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/data/model/location.dart';
import 'package:places/methods.dart';
import 'package:places/redux/action/filters_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/filters_screen_state.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/bottom_button.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Location userLocation = Location(lat: 45, lon: 44);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StoreConnector<AppState, FiltersScreenState>(onInit: (store) {
      store.dispatch(InitFiltersScreenAction());
    }, builder: (BuildContext context, FiltersScreenState vm) {
      if (vm is AtLeastOneCategoryChosenState) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.canvasColor,
              ),
              onPressed: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(ExitFromFiltersScreenAction(context));
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(ClearSelectionsAction());
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
                            radius: filterRepository.candidateRadius,
                            userLocation: userLocation,
                            filterItems: filterRepository.candidateFilterItems,
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
                              'от ${points[vm.radius.start.round()]!.toInt()} до ${points[vm.radius.end.round()]!.toInt()} м',
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
                          values: filterRepository.candidateRadius,
                          onChanged: (values) {
                            StoreProvider.of<AppState>(context)
                                .dispatch(ChangeRangeOfSliderAction(values));
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
                          text:
                              '${AppStrings.showButtonText} (${vm.result.length})',
                          onPressed: () {
                            StoreProvider.of<AppState>(context)
                                .dispatch(ShowResultAction(context, vm.result));
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
      } else if (vm is NoOneCategoryChosenState) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: theme.canvasColor,
              ),
              onPressed: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(ExitFromFiltersScreenAction(context));
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(ClearSelectionsAction());
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
                            radius: filterRepository.candidateRadius,
                            userLocation: userLocation,
                            filterItems: filterRepository.candidateFilterItems,
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
                              'от ${points[vm.radius.start.round()]!.toInt()} до ${points[vm.radius.end.round()]!.toInt()} м',
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
                          values: filterRepository.candidateRadius,
                          onChanged: (values) {
                            StoreProvider.of<AppState>(context)
                                .dispatch(ChangeRangeOfSliderAction(values));
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
                          text: '${AppStrings.showButtonText} (0)',
                          onPressed: null,
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
      return Container();
    }, converter: (store) {
      return store.state.filtersScreenState;
    });
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
      children: filterRepository.candidateFilterItems.map((e) {
        return _CategoryButton(
          name: e,
          isChosen: e.isSelected,
          onPressed: () {
            StoreProvider.of<AppState>(context)
                .dispatch(ClickOnCategoryAction(e));
          },
        );
      }).toList(),
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
