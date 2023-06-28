import 'dart:math';

import 'package:flutter/material.dart';
import 'package:places/data/model/filter_item.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/location.dart';

// ignore: prefer_mixin
class PlaceInteractor with ChangeNotifier {
  static PlaceInteractor? _instance;
  late final PlaceRepository placeRepository;
  List<Place> allPlaces = [];

  // singleton
  factory PlaceInteractor() => _instance ?? PlaceInteractor._internal();
  PlaceInteractor._internal() {
    _instance = this;
    placeRepository = PlaceRepository();
    initPlaces();
    
  }

  Future<void> initPlaces() async {
    await placeRepository.initPlaces();
    allPlaces = placeRepository.places;
    notifyListeners();
  }

  List<Place> getPlaces({
    required RangeValues radius,
    required List<FilterItem> categories,
  }) {
    final filteredAndSortedList = allPlaces
        .where((element) =>
            categories
                .map((e) => e.type)
                .toList()
                .contains(element.placeType) &&
            calcDistance(
                  Location(lat: element.lat, lon: element.lon),
                  getUserLocation(),
                ) >=
                radius.start &&
            calcDistance(
                  Location(lat: element.lat, lon: element.lon),
                  getUserLocation(),
                ) <=
                radius.end)
        .toList()
      ..sort((a, b) =>
          calcDistance(Location(lat: a.lat, lon: a.lon), getUserLocation())
              .compareTo(calcDistance(
            Location(lat: b.lat, lon: b.lon),
            getUserLocation(),
          )));

    return filteredAndSortedList;
  }

  Location getUserLocation() => Location(lat: 54, lon: 54);

  double calcDistance(Location point1, Location point2) {
    const ky = 40000 / 360;
    final kx = cos(pi * point1.lat / 180.0) * ky;
    final dx = (point1.lon - point2.lon).abs() * kx;
    final dy = (point1.lat - point2.lat).abs() * ky;

    return sqrt(dx * dx + dy * dy);
  }

  int findIndexById(String id) {
    for (var i = 0; i < allPlaces.length; i++) {
      if (allPlaces[i].id == id.toString()) {
        return i;
      }
    }
    throw Exception('ID: $id не найден');
  }

  Place getPlaceDetails({required int id}) =>
      allPlaces[findIndexById(id.toString())];

  List<Place> getFavoritesPlaces() {
    final favouritePlaces = allPlaces.where((s) => s.wished).toList();

    return favouritePlaces;
  }

  void addToFavorites({required Place place}) {
    allPlaces[findIndexById(place.id.toString())].wished = true;
    notifyListeners();
  }

  void removeFromFavorites({required Place place}) {
    allPlaces[findIndexById(place.id.toString())].wished = false;
    notifyListeners();
  }

  List<Place> getVisitPlaces() => allPlaces.where((s) => s.seen).toList();

  void addToVisitingPlace({required Place place}) {
    allPlaces[findIndexById(place.id.toString())].seen = true;
    notifyListeners();
  }

  void removeFromVisitingPlace({required Place place}) {
    allPlaces[findIndexById(place.id.toString())].seen = false;
    notifyListeners();
  }

  void addNewPlace({required Place newPlace}) {
    placeRepository.addPlace(newPlace);
    allPlaces.add(newPlace);
    notifyListeners();
  }
}
