import 'package:flutter/material.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/methods.dart';
import 'package:places/redux/action/choosing_category_screen_action.dart';
import 'package:places/redux/state/add_sight_screen_state.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/choosing_category_screen_state.dart';

AppState initChoosingCategoryReducer(
    AppState state, InitChoosingCategoryAction action) {
  if (addSightRepository.activeCategory == null) {
    return state.cloneWith(
        choosingCategoryScreenState:
            ChoosingCategoryScreenMainState(null, true));
  }
  return state.cloneWith(
      choosingCategoryScreenState: ChoosingCategoryScreenMainState(
          addSightRepository.activeCategory, false));
}

AppState chooseCategoryReducer(AppState state, ChooseCategoryAction action) {
  addSightRepository.candidateCategory = action.category;
  return state.cloneWith(
      choosingCategoryScreenState: ChoosingCategoryScreenMainState(
          addSightRepository.candidateCategory,
          addSightRepository.candidateCategory == null));
}

AppState exitFromChoosingCategoryScreenReducer(
    AppState state, ExitFromChoosingCategoryScreenAction action) {
  addSightRepository.candidateCategory = addSightRepository.activeCategory;
  Navigator.pop(action.context);
  return state;
}

AppState returnChosenCategoryReducer(
    AppState state, ReturnChosenCategoryAction action) {
  addSightRepository.activeCategory = addSightRepository.candidateCategory;
  Navigator.pop(action.context);
  return state.cloneWith(
      addSightScreenState: AddSightScreenMainState(
          addSightRepository.images,
          addSightRepository.activeCategory,
          addSightRepository.name,
          addSightRepository.lat,
          addSightRepository.lon,
          addSightRepository.details,
          checkStateOfAddSightFields()));
}
