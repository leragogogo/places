import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/redux/action/favourite_tab_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/favourite_tab_state.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/empty_screen.dart';
import 'package:places/ui/screen/widgets/sight_card_visited.dart';

class WantToVisitTab extends StatefulWidget {
  const WantToVisitTab({super.key});

  @override
  State<StatefulWidget> createState() => _WantToVisitTabState();
}

class _WantToVisitTabState extends State<WantToVisitTab> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StoreConnector<AppState, FavouriteTabState>(
      onInit: (store) {
        store.dispatch(InitFavouriteTabAction(context));
      },
      builder: (BuildContext context, FavouriteTabState vm) {
        if (vm is FavouritePlacesTabDataState) {
          return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ReorderableListView(
                physics: Platform.isAndroid
                    ? const ClampingScrollPhysics()
                    : const BouncingScrollPhysics(),
                proxyDecorator: (child, index, animation) => Material(
                  type: MaterialType.transparency,
                  child: child,
                ),
                onReorder: (oldIndex, newIndex) {
                  StoreProvider.of<AppState>(context)
                      .dispatch(DragFavouritePlaceAction(newIndex, oldIndex));
                },
                children: vm.favouritePlaces
                    .asMap()
                    .entries
                    .map((i) => VisitingSightCard(
                          key: ObjectKey(i.value),
                          sight: i.value,
                          deleteFromList: () {
                            StoreProvider.of<AppState>(context).dispatch(
                                RemoveFavouritePlaceAction(i.value, context));
                          },
                          lowerText: Text(
                            AppStrings.wantToVisitText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.planButtonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leftIcon: const ImageIcon(
                            AssetImage(AppAssets.calendarAsset),
                            color: Colors.white,
                          ),
                          leftIconOnPressed: () {
                            StoreProvider.of<AppState>(context)
                                .dispatch(PlanVisitOfPlaceAction(
                              Platform.isAndroid,
                              context,
                              (val) {
                              },
                            ));
                          },
                        ))
                    .toList(),
              ));
        } else if (vm is FavouritePlacesTabEmptyState) {
          return EmptyScreen(
            path: AppAssets.wantToVisitedEmpty,
            text: AppStrings.wantToVisetedEmptyText,
          );
        }
        return Container();
      },
      converter: (store) {
        return store.state.favouriteTabState;
      },
    );
  }
}
