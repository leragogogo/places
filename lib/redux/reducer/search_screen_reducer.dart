import 'package:places/methods.dart';
import 'package:places/redux/action/search_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/search_screen_state.dart';

AppState removeItemFromHistoryReducer(
    AppState state, RemoveItemFromHistoryAction action) {
  if (action.history.isNotEmpty) {
    action.history.removeAt(action.i);
  }

  return state.cloneWith(
      searchScreenState: SearchScreenHistoryState(action.history));
}

AppState removeAllItemsFromHistoryReducer(
    AppState state, RemoveAllItemsFromHistory action) {
  action.history.removeRange(0, action.history.length);

  return state.cloneWith(
      searchScreenState: SearchScreenHistoryState(action.history));
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
