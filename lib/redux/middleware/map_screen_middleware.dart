import 'package:map_launcher/map_launcher.dart';
import 'package:places/data/model/location.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/database/database.dart';
import 'package:places/location_service.dart';
import 'package:places/redux/action/map_screen_action.dart';
import 'package:places/redux/action/sight_list_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreenMidlleware implements MiddlewareClass<AppState> {
  MapScreenMidlleware();

  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is UpdateMapPointsAction) {
      store.dispatch(LoadSightsAction(action.context));
    }

    if (action is ShowUserLocationAction) {
      if (!await LocationService().checkPermission()) {
        await LocationService().requestPermission();
      }
      var loc = await _fetchCurrentLocation(action);
      var userLocation = Point(latitude: loc.lat, longitude: loc.lon);

      store
          .dispatch(ResultOfUserLocationAction(userLocation, action.mapPoints));
    }

    if (action is BuildRouteAction) {
      final availableMaps = await MapLauncher.installedMaps;
      store.dispatch(
          OpenMapSheetAction(availableMaps, action.context, action.place));
    }

    if (action is AddSightToVisitedAction) {
      if (!visitingScreenRepository.visitedPlaces.contains(action.place)) {
        await action.context.read<AppDb>().addVisitedPlace(
            VisitedPlacesCompanion.insert(title: action.place.id));
        visitingScreenRepository.visitedPlaces.add(action.place);
      }
    }
    next(action);
  }

  Future<Location> _fetchCurrentLocation(ShowUserLocationAction action) async {
    Location location;
    const defLocation = MoscowLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    _moveToCurrentLocation(location, action);
    return location;
  }

  Future<void> _moveToCurrentLocation(
      Location appLatLong, ShowUserLocationAction action) async {
    (await action.mapControllerCompleter.future).moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.lon,
          ),
          zoom: 15,
        ),
      ),
    );
  }
}
