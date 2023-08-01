import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:places/data/model/filter_item.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/domain/location.dart';

part 'sight_list_store.g.dart';

class SightListStore = SightListStoreBase with _$SightListStore;

abstract class SightListStoreBase with Store {
  final PlaceRepository _placeRepository = PlaceRepository();

  List<Place> places = [];

  @observable
  List<Place> filteredPlaces = [];

  @observable
  bool isRequestDoneWithError = false;

  SightListStoreBase() {
    initPlaces();
  }

  @action
  Future<void> initPlaces() async {
    try {
      await _placeRepository.initPlaces();
      places = _placeRepository.places;
      filteredPlaces = _placeRepository.places;
    } catch (e) {
      isRequestDoneWithError = true;
    }
  }

  @action
  void filterPlaces({
    required RangeValues radius,
    required List<FilterItem> categories,
  }) {
    filteredPlaces = places
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
    for (var i = 0; i < filteredPlaces.length; i++) {
      if (filteredPlaces[i].id == id.toString()) {
        return i;
      }
    }
    throw Exception('ID: $id не найден');
  }

  Place getPlaceDetails({required int id}) =>
      places[findIndexById(id.toString())];

  List<Place> getFavoritesPlaces() {
    final favouritePlaces = places.where((s) => s.wished).toList();

    return favouritePlaces;
  }

  int findPlace(Place filPlace) {
    for (var i = 0; i < places.length; i++) {
      if (filPlace == places[i]) {
        return i;
      }
    }
    throw Exception('ID: $filPlace не найден');
  }

  @action
  void addToFavorites({required Place place}) {
    places[findPlace(place)].wished = true;
  }

  @action
  void removeFromFavorites({required Place place}) {
    places[findPlace(place)].wished = false;
  }
}
