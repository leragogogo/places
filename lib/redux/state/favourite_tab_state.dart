import 'package:places/data/model/place.dart';

// Базовое состояние экрана любимые места.
abstract class FavouriteTabState{}

// Инициализирующее состояние экрана любимые места.
class FavouriteTabInitialState extends FavouriteTabState{}

// Состояние экрана любимые места с данными.
class FavouritePlacesTabDataState extends FavouriteTabState{
  List<Place> favouritePlaces;
  FavouritePlacesTabDataState(this.favouritePlaces);
}

// Пустое состояние экрана любимые места.
class FavouritePlacesTabEmptyState extends FavouriteTabState{}

