import 'package:flutter/material.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/redux/action/sight_list_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:redux/redux.dart';

class SightListScreenMiddleware implements MiddlewareClass<AppState> {

  SightListScreenMiddleware();

  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    if (action is LoadSightsAction) {
      try {
        placeRepository.loadPlaces().then((result) {
          debugPrint('places are loaded');
          store.dispatch(ResultSightsAction(placeRepository.places));
        });
      } catch (e) {
        store.dispatch(ErrorAction());
      }
    }
    next(action);
  }
}
