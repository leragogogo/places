import 'package:flutter/material.dart';
import 'package:places/data/model/map_point.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/redux/action/sight_list_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/map_screen_state.dart';
import 'package:places/redux/state/sight_list_screen_state.dart';
import 'package:places/redux/state/favourite_tab_state.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/sight_search_screen.dart';

AppState loadSightsReducer(AppState state, LoadSightsAction action) {
  return state.cloneWith(sightListScreenState: SightListScreenLoadingState());
}

AppState resultSightsReducer(AppState state, ResultSightsAction action) {
  return state.cloneWith(
      sightListScreenState: SightListScreenDataState(action.places),
      mapScreenState: MapScreenMainState(
          action.places
              .map((place) => MapPoint(
                  name: place.name,
                  latitude: place.lat,
                  longitude: place.lon,
                  isClicked: false))
              .toList(),
          null));
}

AppState errorReducer(AppState state, ErrorAction action) {
  return state.cloneWith(sightListScreenState: SightListScreenErrorState());
}

AppState addSightToFavouriteReducer(
    AppState state, AddSightToFavouriteAction action) {
  return state.cloneWith(
      sightListScreenState: SightListScreenDataState(action.places),
      favouriteTabState: FavouritePlacesTabDataState(
          visitingScreenRepository.favouritePlaces));
}

AppState openSearchScreenReducer(
    AppState state, OpenSearchScreenAction action) {
  Navigator.push(
    action.context,
    MaterialPageRoute<SightSearchScreen>(
      builder: (context) => SightSearchScreen(),
    ),
  );
  return state;
}

AppState openFiltersScreenReducer(
    AppState state, OpenFiltersScreenAction action) {
  Navigator.push(
    action.context,
    MaterialPageRoute<List<dynamic>>(
      builder: (context) => FiltersScreen(),
    ),
  );
  return state;
}
