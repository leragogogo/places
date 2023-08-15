import 'package:places/redux/state/search_screen_state.dart';

/// Состояние экрана.
class AppState {
  final SearchScreenState searchScreenState;

  AppState(SearchScreenState? searchScreenState)
      : this.searchScreenState =
            searchScreenState ?? SearchScreenInitialState();

  AppState cloneWith(SearchScreenState? searchScreenState) =>
      AppState(searchScreenState ?? this.searchScreenState);
}
