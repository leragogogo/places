import 'package:places/data/repository/repositories.dart';
import 'package:places/redux/action/visited_tab_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/visited_tab_state.dart';

AppState removeVisitedPlaceReducer(
    AppState state, RemoveVisitedPlaceAction action) {
  if (visitingScreenRepository.visitedPlaces.isEmpty) {
    return state.cloneWith(visitedPlacesTabState: VisitedPlacesTabEmptyState());
  }
  return state.cloneWith(
      visitedPlacesTabState:
          VisitedPlacesTabDataState(visitingScreenRepository.visitedPlaces));
}

AppState initVisitedTabReducer(AppState state, InitVisitedTabAction action) {
  if (visitingScreenRepository.visitedPlaces.isEmpty) {
    return state.cloneWith(visitedPlacesTabState: VisitedPlacesTabEmptyState());
  }
  return state.cloneWith(
      visitedPlacesTabState:
          VisitedPlacesTabDataState(visitingScreenRepository.visitedPlaces));
}

AppState dragVisitedPlaceReducer(
    AppState state, DragVisitedPlaceAction action) {
  var visitedPlaces = visitingScreenRepository.visitedPlaces;
  if (action.newIndex > action.oldIndex) action.newIndex -= 1;
  final item = visitedPlaces.removeAt(action.oldIndex);
  visitedPlaces.insert(action.newIndex, item);
  return state.cloneWith(
      visitedPlacesTabState: VisitedPlacesTabDataState(visitedPlaces));
}


