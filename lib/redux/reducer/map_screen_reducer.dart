import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:places/data/model/map_point.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/methods.dart';
import 'package:places/redux/action/map_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/map_screen_state.dart';
import 'package:places/redux/state/visited_tab_state.dart';

AppState initMapPointsReducer(AppState state, InitMapPointsAction action) {
  final filteredPlaces = getFilteredPlaces();
  return state.cloneWith(
      mapScreenState: MapScreenMainState(
          filteredPlaces
              .map((place) => MapPoint(
                  name: place.name,
                  latitude: place.lat,
                  longitude: place.lon,
                  isClicked: false))
              .toList(),
          null));
}

AppState updateMapPointsReducer(AppState state, UpdateMapPointsAction action) {
  return state;
}

AppState showUserLocationReducer(
    AppState state, ShowUserLocationAction action) {
  return state;
}

AppState resultOfUserLocationReducer(
    AppState state, ResultOfUserLocationAction action) {
  return state.cloneWith(
      mapScreenState:
          MapScreenMainState(action.mapPoints, action.userLocation));
}

AppState clickOnMapPointReducer(AppState state, ClickOnMapPointAction action) {
  for (final mapPoint in action.mapPoints) {
    if (mapPoint == action.point) {
      mapPoint.isClicked = !mapPoint.isClicked;
    } else {
      mapPoint.isClicked = false;
    }
  }
  return state.cloneWith(
      mapScreenState:
          MapScreenMainState(action.mapPoints, action.userLocation));
}

AppState buildRouteReducer(AppState state, BuildRouteAction action) {
  return state;
}

AppState openMapSheetReducer(AppState state, OpenMapSheetAction action) {
  showModalBottomSheet(
    context: action.context,
    builder: (BuildContext context) {
      return SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Wrap(
              children: <Widget>[
                for (var map in action.availableMaps)
                  ListTile(
                    onTap: () => map.showMarker(
                      coords: Coords(action.place.lat, action.place.lon),
                      title: action.place.name,
                      description: action.place.description,
                    ),
                    title: Text(map.mapName),
                    leading: SvgPicture.asset(
                      map.icon,
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
  return state;
}

AppState addSightToVisitedReducer(
    AppState state, AddSightToVisitedAction action) {
  return state.cloneWith(
      visitedPlacesTabState:
          VisitedPlacesTabDataState(visitingScreenRepository.visitedPlaces));
}
