import 'package:flutter/material.dart';
import 'package:places/data/model/filter_item.dart';
import 'package:places/data/model/place.dart';

// Базовое действия экрана фильтров.
abstract class FiltersScreenAction {}

// Инициализация экрана фильтров.
class InitFiltersScreenAction extends FiltersScreenAction {
  BuildContext context;
  InitFiltersScreenAction(this.context);
}

// Клик на категорию.
class ClickOnCategoryAction extends FiltersScreenAction {
  FilterItem category;
  ClickOnCategoryAction(this.category);
}

// Изменение диапозона расстояния до мест.
class ChangeRangeOfSliderAction extends FiltersScreenAction {
  RangeValues range;
  ChangeRangeOfSliderAction(this.range);
}

// Очищение фильтров.
class ClearSelectionsAction extends FiltersScreenAction {}

// Показать отифильтрованные места.
class ShowResultAction extends FiltersScreenAction {
  BuildContext context;
  List<Place> result;
  ShowResultAction(this.context, this.result);
}

// Выход с экрана фильтров.
class ExitFromFiltersScreenAction extends FiltersScreenAction {
  BuildContext context;
  ExitFromFiltersScreenAction(this.context);
}
