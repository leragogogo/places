import 'package:places/redux/state/add_sight_screen_state.dart';
import 'package:places/redux/state/choosing_category_screen_state.dart';
import 'package:places/redux/state/favourite_tab_state.dart';
import 'package:places/redux/state/filters_screen_state.dart';
import 'package:places/redux/state/map_screen_state.dart';
import 'package:places/redux/state/search_screen_state.dart';
import 'package:places/redux/state/sight_list_screen_state.dart';
import 'package:places/redux/state/visited_tab_state.dart';

/// Состояние экрана.
class AppState {
  final SearchScreenState searchScreenState;
  final SightListScreenState sightListScreenState;
  final FavouriteTabState favouriteTabState;
  final FiltersScreenState filtersScreenState;
  final AddSightScreenState addSightScreenState;
  final ChoosingCategoryScreenState choosingCategoryScreenState;
  final MapScreenState mapScreenState;
  final VisitedPlacesTabState visitedPlacesTabState;

  AppState(
      {SearchScreenState? searchScreenState,
      SightListScreenState? sightListScreenState,
      FavouriteTabState? favouriteTabState,
      FiltersScreenState? filtersScreenState,
      AddSightScreenState? addSightScreenState,
      ChoosingCategoryScreenState? choosingCategoryScreenState,
      MapScreenState? mapScreenState,
      VisitedPlacesTabState? visitedPlacesTabState})
      : this.searchScreenState =
            searchScreenState ?? SearchScreenInitialState(),
        this.sightListScreenState =
            sightListScreenState ?? SightListScreenInitialState(),
        this.favouriteTabState =
            favouriteTabState ?? FavouriteTabInitialState(),
        this.filtersScreenState =
            filtersScreenState ?? FiltersScreenInitialState(),
        this.addSightScreenState =
            addSightScreenState ?? AddSightScreenInitialState(),
        this.choosingCategoryScreenState =
            choosingCategoryScreenState ?? ChoosingCategoryScreenInitialState(),
        this.mapScreenState = mapScreenState ?? MapScreenInitialState(),
        this.visitedPlacesTabState =
            visitedPlacesTabState ?? VisitedPlacesTabInitialState();

  AppState cloneWith(
          {SearchScreenState? searchScreenState,
          SightListScreenState? sightListScreenState,
          FavouriteTabState? favouriteTabState,
          FiltersScreenState? filtersScreenState,
          AddSightScreenState? addSightScreenState,
          ChoosingCategoryScreenState? choosingCategoryScreenState,
          MapScreenState? mapScreenState,
          VisitedPlacesTabState? visitedPlacesTabState}) =>
      AppState(
          searchScreenState: searchScreenState ?? this.searchScreenState,
          sightListScreenState:
              sightListScreenState ?? this.sightListScreenState,
          favouriteTabState: favouriteTabState ?? this.favouriteTabState,
          filtersScreenState: filtersScreenState ?? this.filtersScreenState,
          addSightScreenState: addSightScreenState ?? this.addSightScreenState,
          choosingCategoryScreenState:
              choosingCategoryScreenState ?? this.choosingCategoryScreenState,
          mapScreenState: mapScreenState ?? this.mapScreenState,
          visitedPlacesTabState: visitedPlacesTabState ?? this.visitedPlacesTabState,
          );
}
