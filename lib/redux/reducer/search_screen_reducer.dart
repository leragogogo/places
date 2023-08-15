import 'package:places/redux/action/search_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/search_screen_state.dart';

AppState removeItemFromHistoryReducer(
    AppState state, RemoveItemFromHistoryAction action) {
  if (action.history.isNotEmpty) {
    action.history.removeAt(action.i);
  }

  return state.cloneWith(SearchScreenHistoryState(action.history));
}

AppState removeAllItemsFromHistoryReducer(
    AppState state, RemoveAllItemsFromHistory action) {
  action.history.removeRange(0, action.history.length);

  return state.cloneWith(SearchScreenHistoryState(action.history));
}

AppState searchTextWasUpdatedReducer(
    AppState state, SearchTextWasUpdatedAction action) {
  var result = action.searchInteractor.searchPlaces(action.searchText);
  if (action.searchText == '') {
    return state.cloneWith(SearchScreenHistoryState(action.history));
  }
  if (result.isEmpty) {
    return state.cloneWith(SearchSreenErrorState());
  }
  return state.cloneWith(SearchScreenDataState(result));
}
