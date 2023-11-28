import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/redux/action/favourite_tab_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/favourite_tab_state.dart';
import 'package:places/ui/screen/res/app_colors.dart';

AppState removeFavouritePlaceReducer(
    AppState state, RemoveFavouritePlaceAction action) {
  if (visitingScreenRepository.favouritePlaces.isEmpty) {
    return state.cloneWith(favouriteTabState: FavouritePlacesTabEmptyState());
  }
  return state.cloneWith(
      favouriteTabState: FavouritePlacesTabDataState(
          visitingScreenRepository.favouritePlaces));
}

AppState initFavouriteTabReducer(
    AppState state, InitFavouriteTabAction action) {
  if (visitingScreenRepository.favouritePlaces.isEmpty) {
    return state.cloneWith(favouriteTabState: FavouritePlacesTabEmptyState());
  }
  return state.cloneWith(
      favouriteTabState: FavouritePlacesTabDataState(
          visitingScreenRepository.favouritePlaces));
}

AppState dragFavouritePlaceReducer(
    AppState state, DragFavouritePlaceAction action) {
  var favouritePlaces = visitingScreenRepository.favouritePlaces;
  if (action.newIndex > action.oldIndex) action.newIndex -= 1;
  final item = favouritePlaces.removeAt(action.oldIndex);
  favouritePlaces.insert(action.newIndex, item);
  return state.cloneWith(
      favouriteTabState: FavouritePlacesTabDataState(favouritePlaces));
}

AppState planVisitOfPlaceReducer(
    AppState state, PlanVisitOfPlaceAction action) {
  final theme = Theme.of(action.context);
  if (action.isAndroid) {
    showDatePicker(
      context: action.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.planButtonColor,
              onSurface: theme.canvasColor,
            ),
            dialogBackgroundColor: theme.appBarTheme.backgroundColor,
          ),
          child: child!,
        );
      },
    );
  } else {
    showCupertinoModalPopup<DateTime>(
      context: action.context,
      builder: (_) {
        return Container(
          height: MediaQuery.of(action.context).size.height * 0.5,
          color: theme.appBarTheme.backgroundColor,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle:
                          theme.textTheme.bodyMedium?.copyWith(
                        color: theme.canvasColor,
                      ),
                    ),
                  ),
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: action.onDateTimeChanged,
                  ),
                ),
              ),
              Expanded(
                child: CupertinoButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: AppColors.planButtonColor,
                    ),
                  ),
                  onPressed: () => Navigator.of(action.context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  return state;
}
