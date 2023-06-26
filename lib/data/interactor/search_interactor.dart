import 'package:flutter/cupertino.dart';
import 'package:places/data/interactor/filter_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/search_repository.dart';

class SearchInteractor extends ChangeNotifier {
  static SearchInteractor? _instance;
  final placeInteractor = PlaceInteractor();
  final searchRepository = SearchRepository();
  final filterInteractor = FilterInteractor();

  late final List<String> _history;

  List<String> get lastSearches {
    return _history;
  }

  // singleton
  factory SearchInteractor() => _instance ?? SearchInteractor._internal();
  SearchInteractor._internal() {
    _instance = this;
    _history = searchRepository.history;
  }

  List<Place> searchPlaces(String searchText) {
    if (searchText == '') {
      return [];
    }
    final result = <Place>[];
    final categories = filterInteractor.getSelectedActiveCategories();
    final filteredPlaces = placeInteractor.getPlaces(
      radius: filterInteractor.activeCurRadius,
      categories: categories,
    );
    for (final place in filteredPlaces) {
      if (place.name.toLowerCase().contains(searchText.toLowerCase())) {
        result.add(place);
      }
    }
    _history.add(searchText);

    return result;
  }
}
