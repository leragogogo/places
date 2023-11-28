import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/database/database.dart';
import 'package:places/methods.dart';
import 'package:places/redux/action/sight_list_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class SightListScreenMiddleware implements MiddlewareClass<AppState> {
  SightListScreenMiddleware();

  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadSightsAction) {
      try {
        placeRepository.loadPlaces().then((result) async {
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
          store.dispatch(ResultSightsAction(getFilteredPlaces()));
        });
      } catch (e) {
        store.dispatch(ErrorAction());
      }
    }
    if (action is AddSightToFavouriteAction) {
      if (!visitingScreenRepository.favouritePlaces.contains(action.place)) {
        await action.context.read<AppDb>().addFavouritePlace(
            FavouritePlacesCompanion.insert(title: action.place.id));
        visitingScreenRepository.favouritePlaces.add(action.place);
      }
    }
    next(action);
  }
}
