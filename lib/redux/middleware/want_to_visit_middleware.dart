import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/database/database.dart';
import 'package:places/redux/action/favourite_tab_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class WantToVisitMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is RemoveFavouritePlaceAction) {
      debugPrint('id: ${action.placeForRemoval.id}');
      await action.context
          .read<AppDb>()
          .removeFavouritePlace(action.placeForRemoval.id);
      visitingScreenRepository.favouritePlaces.remove(action.placeForRemoval);
    }
    if (action is InitFavouriteTabAction) {
      var _db = action.context.read<AppDb>();

      var favouritePlacesDb = await _db.allFavouritePlaces;
      var res = <Place>[];

      for (final place in favouritePlacesDb) {
        for (var p in placeRepository.places) {
          if (p.id == place.title) {
            res.add(p);
            break;
          }
        }
      }
      visitingScreenRepository.favouritePlaces = res;
    }
    next(action);
  }
}
