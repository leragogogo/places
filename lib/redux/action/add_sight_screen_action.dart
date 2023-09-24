import 'package:flutter/widgets.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/categories.dart';

// Базовое действие экрана добавить место.
abstract class AddSightScreenAction {}

// Инициализация экрана добавить место.
class InitAddSightScreenAction {}

// Выбор картинок для нового места.
class ChooseImagesAction extends AddSightScreenAction {
  BuildContext context;
  ChooseImagesAction(this.context);
}

// Удалить картинку.
class RemoveImageAction extends AddSightScreenAction {
  int index;
  RemoveImageAction(this.index);
}

// Открытие экрана выбора категориию
class OpenChoosingCategoryScreenAction extends AddSightScreenAction {
  BuildContext context;
  OpenChoosingCategoryScreenAction(this.context);
}

// Заполнение поля с именем места.
class FillNameAction extends AddSightScreenAction {
  String name;
  FillNameAction(this.name);
}

// Заполнение поля с широтой места.
class FillLatAction extends AddSightScreenAction {
  double lat;
  FillLatAction(this.lat);
}

// Заполнение поля с долготой места.
class FillLonAction extends AddSightScreenAction {
  double lon;
  FillLonAction(this.lon);
}

// Выбор локации места на карте.
class ChooseLocationOnMapAction extends AddSightScreenAction {}

// Заполнение описание места.
class FillDescriptionAction extends AddSightScreenAction {
  String description;
  FillDescriptionAction(this.description);
}

// Нажатие на кнопку создать новое место.
class CreateNewPlaceAction extends AddSightScreenAction {
  List<String> images;
  Categories category;
  String name;
  double lat;
  double lon;
  String description;
  BuildContext context;
  CreateNewPlaceAction(this.images, this.category, this.name, this.lat,
      this.lon, this.description, this.context);
}

// Успешное создание нового места.
class SuccesCreatingNewPlaceAction extends AddSightScreenAction {
  Place newPlace;
  BuildContext context;
  SuccesCreatingNewPlaceAction(this.newPlace, this.context);
}

// Ошибка при создании нового места.
class ErrorCreatingNewPlaceAction extends AddSightScreenAction {
  BuildContext context;
  ErrorCreatingNewPlaceAction(this.context);
}

// Вызод с экрана создания нового места.
class ExitFromAddSightScreenAction extends AddSightScreenAction {
  BuildContext context;
  ExitFromAddSightScreenAction(this.context);
}
