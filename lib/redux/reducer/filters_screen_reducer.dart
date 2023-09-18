import 'package:flutter/material.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/methods.dart';
import 'package:places/redux/action/filters_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/filters_screen_state.dart';
import 'package:places/redux/state/sight_list_screen_state.dart';

AppState clickOnCategoryReducer(AppState state, ClickOnCategoryAction action) {
  for (var category in filterRepository.candidateFilterItems) {
    if (category == action.category) {
      category.isSelected = !category.isSelected;
    }
  }
  var filteredPlaces = getFilteredPlaces();

  return filteredPlaces.isEmpty
      ? state.cloneWith(
          filtersScreenState:
              NoOneCategoryChosenState(filterRepository.candidateRadius))
      : state.cloneWith(
          filtersScreenState: AtLeastOneCategoryChosenState(
              filterRepository.candidateFilterItems,
              filterRepository.candidateRadius,
              filteredPlaces));
}

AppState changeRangeOfSliderReducer(
    AppState state, ChangeRangeOfSliderAction action) {
  filterRepository.candidateRadius = action.range;

  var filteredPlaces = getFilteredPlaces();

  return filteredPlaces.isEmpty
      ? state.cloneWith(
          filtersScreenState:
              NoOneCategoryChosenState(filterRepository.candidateRadius))
      : state.cloneWith(
          filtersScreenState: AtLeastOneCategoryChosenState(
              filterRepository.candidateFilterItems,
              filterRepository.candidateRadius,
              filteredPlaces));
}

AppState clearSelectionsReducer(AppState state, ClearSelectionsAction action) {
  for (var category in filterRepository.candidateFilterItems) {
    category.isSelected = false;
  }
  filterRepository.candidateRadius = RangeValues(1, 10);
  return state.cloneWith(
      filtersScreenState:
          NoOneCategoryChosenState(filterRepository.candidateRadius));
}

AppState showResultReducer(AppState state, ShowResultAction action) {
  for (var i = 0; i < filterRepository.candidateFilterItems.length; i++) {
    filterRepository.activeFilterItems[i].isSelected =
        filterRepository.candidateFilterItems[i].isSelected;
  }

  filterRepository.activeRadius = RangeValues(
      filterRepository.candidateRadius.start,
      filterRepository.candidateRadius.end);
  Navigator.pop(action.context, <dynamic>[]);
  return state.cloneWith(
      sightListScreenState: SightListScreenDataState(action.result));
}

AppState exitFromFiltersScreenReducer(
    AppState state, ExitFromFiltersScreenAction action) {
  for (var i = 0; i < filterRepository.candidateFilterItems.length; i++) {
    filterRepository.candidateFilterItems[i].isSelected =
        filterRepository.activeFilterItems[i].isSelected;
  }

  filterRepository.candidateRadius = RangeValues(
      filterRepository.activeRadius.start, filterRepository.activeRadius.end);
  Navigator.pop(action.context);
  return state;
}

AppState initFiltersScreenReducer(
    AppState state, InitFiltersScreenAction action) {
  var filteredPlaces = getFilteredPlaces();

  return filteredPlaces.isEmpty
      ? state.cloneWith(
          filtersScreenState:
              NoOneCategoryChosenState(filterRepository.candidateRadius))
      : state.cloneWith(
          filtersScreenState: AtLeastOneCategoryChosenState(
              filterRepository.activeFilterItems,
              filterRepository.activeRadius,
              filteredPlaces));
}
