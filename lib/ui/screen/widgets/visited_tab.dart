import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/redux/action/visited_tab_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/visited_tab_state.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/empty_screen.dart';
import 'package:places/ui/screen/widgets/sight_card_visited.dart';

class VisitedTab extends StatefulWidget {
  const VisitedTab({super.key});

  @override
  State<StatefulWidget> createState() => _VisitedTabState();
}

class _VisitedTabState extends State<VisitedTab> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StoreConnector<AppState, VisitedPlacesTabState>(
      onInit: (store) {
        store.dispatch(InitVisitedTabAction(context));
      },
      builder: (BuildContext context, VisitedPlacesTabState vm) {
        if (vm is VisitedPlacesTabDataState) {
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
                      .dispatch(DragVisitedPlaceAction(newIndex, oldIndex));
                },
                children: vm.visitedPlaces
                    .asMap()
                    .entries
                    .map((i) => VisitingSightCard(
                          key: ObjectKey(i.value),
                          sight: i.value,
                          deleteFromList: () {
                            StoreProvider.of<AppState>(context).dispatch(
                                RemoveVisitedPlaceAction(i.value, context));
                          },
                          lowerText: Text(
                            AppStrings.visitedText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.primaryColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leftIcon: const Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          leftIconOnPressed: () {},
                        ))
                    .toList(),
              ));
        }
        if (vm is VisitedPlacesTabEmptyState) {
          return const EmptyScreen(
            path: AppAssets.visitedEmpty,
            text: AppStrings.visitedEmptyText,
          );
        }
        return Container();
      },
      converter: (store) {
        return store.state.visitedPlacesTabState;
      },
    );
  }
}
