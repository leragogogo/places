import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:places/data/model/map_point.dart';
import 'package:places/data/model/place.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract class MapScreenAction {}

class InitMapPointsAction extends MapScreenAction {
  InitMapPointsAction();
}

class UpdateMapPointsAction extends MapScreenAction {
  BuildContext context;
  UpdateMapPointsAction(this.context);
}

class ShowUserLocationAction extends MapScreenAction {
  List<MapPoint> mapPoints;
  Completer<YandexMapController> mapControllerCompleter;
  ShowUserLocationAction(this.mapPoints, this.mapControllerCompleter);
}

class ResultOfUserLocationAction extends MapScreenAction {
  Point userLocation;
  List<MapPoint> mapPoints;
  ResultOfUserLocationAction(this.userLocation, this.mapPoints);
}

class ClickOnMapPointAction extends MapScreenAction {
  MapPoint point;
  Point? userLocation;
  List<MapPoint> mapPoints;
  ClickOnMapPointAction(this.point, this.userLocation, this.mapPoints);
}

class BuildRouteAction extends MapScreenAction {
  BuildContext context;
  Place place;
  BuildRouteAction(this.context, this.place);
}

class OpenMapSheetAction extends MapScreenAction {
  List<AvailableMap> availableMaps;
  BuildContext context;
  Place place;
  OpenMapSheetAction(this.availableMaps, this.context, this.place);
}

class AddSightToVisitedAction extends MapScreenAction {
  Place place;
  BuildContext context;
  AddSightToVisitedAction(this.place, this.context);
}
