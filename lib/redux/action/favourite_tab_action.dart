import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

// Базовое действие экрана любимых мест.
abstract class FavouriteTabAction {}

// Инициализация экрана любимых мест.
class InitFavouriteTabAction extends FavouriteTabAction {
  BuildContext context;
  InitFavouriteTabAction(this.context);
}

// Удаление места из списка любимых
class RemoveFavouritePlaceAction extends FavouriteTabAction {
  Place placeForRemoval;
  BuildContext context;
  RemoveFavouritePlaceAction(this.placeForRemoval, this.context);
}

// Перетягивание места по списку любимых.
class DragFavouritePlaceAction extends FavouriteTabAction {
  int oldIndex;
  int newIndex;
  DragFavouritePlaceAction(this.newIndex, this.oldIndex);
}

// Планирование посещения любимого места.
class PlanVisitOfPlaceAction extends FavouriteTabAction {
  bool isAndroid;
  BuildContext context;
  Function(DateTime) onDateTimeChanged;
  PlanVisitOfPlaceAction(this.isAndroid, this.context, this.onDateTimeChanged);
}
