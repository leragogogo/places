import 'package:places/redux/state/add_sight_screen_state.dart';
import 'package:places/redux/state/choosing_category_screen_state.dart';
import 'package:places/redux/state/favourite_tab_state.dart';
import 'package:places/redux/state/filters_screen_state.dart';
import 'package:places/redux/state/search_screen_state.dart';
import 'package:places/redux/state/sight_list_screen_state.dart';

/// Состояние экрана.
class AppState {
  final SearchScreenState searchScreenState;
  final SightListScreenState sightListScreenState;
  final FavouriteTabState favouriteTabState;
  final FiltersScreenState filtersScreenState;
  final AddSightScreenState addSightScreenState;
  final ChoosingCategoryScreenState choosingCategoryScreenState;

  AppState(
      {SearchScreenState? searchScreenState,
      SightListScreenState? sightListScreenState,
      FavouriteTabState? favouriteTabState,
      FiltersScreenState? filtersScreenState,
      AddSightScreenState? addSightScreenState,
      ChoosingCategoryScreenState? choosingCategoryScreenState})
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
            choosingCategoryScreenState ?? ChoosingCategoryScreenInitialState();

  AppState cloneWith(
          {SearchScreenState? searchScreenState,
          SightListScreenState? sightListScreenState,
          FavouriteTabState? favouriteTabState,
          FiltersScreenState? filtersScreenState,
          AddSightScreenState? addSightScreenState,
          ChoosingCategoryScreenState? choosingCategoryScreenState}) =>
      AppState(
        searchScreenState: searchScreenState ?? this.searchScreenState,
        sightListScreenState: sightListScreenState ?? this.sightListScreenState,
        favouriteTabState: favouriteTabState ?? this.favouriteTabState,
        filtersScreenState: filtersScreenState ?? this.filtersScreenState,
        addSightScreenState: addSightScreenState ?? this.addSightScreenState,
        choosingCategoryScreenState:
            choosingCategoryScreenState ?? this.choosingCategoryScreenState,
      );
}
