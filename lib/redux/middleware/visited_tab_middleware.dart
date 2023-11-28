import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/database/database.dart';
import 'package:places/redux/action/visited_tab_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class VisitedTabMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is RemoveVisitedPlaceAction) {
      await action.context
          .read<AppDb>()
          .removeVisitedPlace(action.placeForRemoval.id);
      visitingScreenRepository.visitedPlaces.remove(action.placeForRemoval);
    }
    if (action is InitVisitedTabAction) {
      var _db = action.context.read<AppDb>();

      var visitedPlacesDb = await _db.allVisitedPlaces;
      var res = <Place>[];

      for (final place in visitedPlacesDb) {
        for (var p in placeRepository.places) {
          if (p.id == place.title) {
            res.add(p);
            break;
          }
        }
      }
      visitingScreenRepository.visitedPlaces = res;
    }
    next(action);
  }
}
