import 'package:places/data/model/place.dart';

/// Базовое состояние экрана мест.
abstract class SightListScreenState {}

// Инициализирующее состояние экрана мест.
class SightListScreenInitialState extends SightListScreenState {}

// Состояние загрузки экрана мест.
class SightListScreenLoadingState extends SightListScreenState {}

// Состояние экрана мест с данными.
class SightListScreenDataState extends SightListScreenState {
  List<Place> places;
  SightListScreenDataState(this.places);
}

// Состояние ошибки экрана мест.
class SightListScreenErrorState extends SightListScreenState {}
