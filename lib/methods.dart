import 'dart:math';
import 'package:places/data/model/filter_item.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/data/model/location.dart';

bool checkStateOfAddSightFields() {
  return addSightRepository.activeCategory != null &&
      addSightRepository.details != '' &&
      addSightRepository.lat != null &&
      addSightRepository.lon != null &&
      addSightRepository.lon != null &&
      addSightRepository.name != '';
}

// соответсвие между значениями слайдера и длиной радиуса поиска в метрах
Map<int, double> points = {
  1: 100,
  2: 500,
  3: 1000,
  4: 2000,
  5: 3000,
  6: 4000,
  7: 5000,
  8: 6000,
  9: 7500,
  10: 10000,
};
Location getUserLocation() => Location(lat: 54, lon: 54);

double calcDistance(Location point1, Location point2) {
  const ky = 40000 / 360;
  final kx = cos(pi * point1.lat / 180.0) * ky;
  final dx = (point1.lon - point2.lon).abs() * kx;
  final dy = (point1.lat - point2.lat).abs() * ky;

  return sqrt(dx * dx + dy * dy);
}

List<FilterItem> getSelectedCategories() {
  var selectedCategories = <FilterItem>[];
  for (var category in filterRepository.candidateFilterItems) {
    if (category.isSelected) {
      selectedCategories.add(category);
    }
  }
  return selectedCategories;
}

List<Place> getFilteredPlaces() {
  var selectedCategories = getSelectedCategories();

  return placeRepository.places
      .where((element) =>
          selectedCategories
              .map((e) => e.type)
              .toList()
              .contains(element.placeType) &&
          calcDistance(
                Location(lat: element.lat, lon: element.lon),
                getUserLocation(),
              ) >=
              points[filterRepository.candidateRadius.start.round()]! &&
          calcDistance(
                Location(lat: element.lat, lon: element.lon),
                getUserLocation(),
              ) <=
              points[filterRepository.candidateRadius.end.round()]!)
      .toList()
    ..sort((a, b) =>
        calcDistance(Location(lat: a.lat, lon: a.lon), getUserLocation())
            .compareTo(calcDistance(
          Location(lat: b.lat, lon: b.lon),
          getUserLocation(),
        )));
}

List<Place> searchPlaces(String searchText) {
  if (searchText == '') {
    return [];
  }
  final result = <Place>[];
  final filteredPlaces = getFilteredPlaces();
  for (final place in filteredPlaces) {
    if (place.name.toLowerCase().contains(searchText.toLowerCase())) {
      result.add(place);
    }
  }
  return result;
}
