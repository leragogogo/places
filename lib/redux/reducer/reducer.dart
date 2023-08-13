import 'package:places/redux/action/search_screen_action.dart';
import 'package:places/redux/reducer/search_screen_reducer.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:redux/redux.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, RemoveItemFromHistoryAction>(
      removeItemFromHistoryReducer),
  TypedReducer<AppState, RemoveAllItemsFromHistory>(
      removeAllItemsFromHistoryReducer),
  TypedReducer<AppState, SearchTextWasUpdatedAction>(
      searchTextWasUpdatedReducer),
]);
