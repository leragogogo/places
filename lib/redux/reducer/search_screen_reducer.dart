import 'package:places/data/repository/repositories.dart';
import 'package:places/methods.dart';
import 'package:places/redux/action/search_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/search_screen_state.dart';

AppState initSearchScreenReducer(
    AppState state, InitSearchScreenAction action) {
  return state.cloneWith(
      searchScreenState: SearchScreenHistoryState(searchRepository.history));
}

AppState removeItemFromHistoryReducer(
    AppState state, RemoveItemFromHistoryAction action) {
  return state.cloneWith(
      searchScreenState: SearchScreenHistoryState(searchRepository.history));
}

AppState tapOnMiniCardSightReducer(AppState state, TapOnMiniCardSight action) {
  return state; 
}

AppState removeAllItemsFromHistoryReducer(
    AppState state, RemoveAllItemsFromHistory action) {
  return state.cloneWith(
      searchScreenState: SearchScreenHistoryState([]));
}

AppState searchTextWasUpdatedReducer(
    AppState state, SearchTextWasUpdatedAction action) {
  var result = searchPlaces(action.searchText);
  if (action.searchText == '') {
    return state.cloneWith(
        searchScreenState: SearchScreenHistoryState(action.history));
  }
  if (result.isEmpty) {
    return state.cloneWith(searchScreenState: SearchSreenErrorState());
  }
  return state.cloneWith(searchScreenState: SearchScreenDataState(result));
}
