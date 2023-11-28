import 'package:places/data/model/place.dart';
import 'package:places/database/database.dart';

/// Базовое состояние экрана поиска.
abstract class SearchScreenState {}

/// Начальное состояние экрана поиска.
class SearchScreenInitialState extends SearchScreenState {}

/// Состояние экрана с поисковыми данными.
class SearchScreenDataState extends SearchScreenState {
  List<Place> places;
  SearchScreenDataState(this.places);
}

/// Состояние экрана с историей поиска.
class SearchScreenHistoryState extends SearchScreenState {
  List<History> history;
  SearchScreenHistoryState(this.history);
}

/// Состояние экрана поиска когда по запросу ничего не найдено.
class SearchSreenErrorState extends SearchScreenState {}
