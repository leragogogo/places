import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

// Базовое действие экрана мест.
abstract class SightListScreenAction {}

// Загрузка мест с сервера.
class LoadSightsAction extends SightListScreenAction {
  BuildContext context;
  LoadSightsAction(this.context);
}

// Результат загрузки мест с сервера.
class ResultSightsAction extends SightListScreenAction {
  List<Place> places;
  ResultSightsAction(this.places);
}

// Ошибка при загрузки мест с сервера.
class ErrorAction extends SightListScreenAction {}

// Добавление места в список любимых.
class AddSightToFavouriteAction extends SightListScreenAction {
  List<Place> places;
  Place place;
  BuildContext context;
  AddSightToFavouriteAction(this.place, this.places,this.context);
}

// Открытие экрана поиска.
class OpenSearchScreenAction extends SightListScreenAction {
  BuildContext context;
  OpenSearchScreenAction(this.context);
}

// Открытие экрана фильтроф.
class OpenFiltersScreenAction extends SightListScreenAction {
  BuildContext context;
  OpenFiltersScreenAction(this.context);
}
