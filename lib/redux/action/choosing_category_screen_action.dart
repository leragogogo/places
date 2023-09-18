import 'package:flutter/cupertino.dart';
import 'package:places/data/model/categories.dart';

// Базовое действие экрана выбора категории.
abstract class ChoosingCategoryScreenAction {}

// Инициализация экрана выбора категории.
class InitChoosingCategoryAction extends ChoosingCategoryScreenAction {}

// Выбор категории.
class ChooseCategoryAction extends ChoosingCategoryScreenAction {
  Categories category;
  ChooseCategoryAction(this.category);
}

// Выход с экрана выбора категории.
class ExitFromChoosingCategoryScreenAction
    extends ChoosingCategoryScreenAction {
  BuildContext context;
  ExitFromChoosingCategoryScreenAction(this.context);
}

// Нажатие на кнопку сохранить категорию.
class ReturnChosenCategoryAction extends ChoosingCategoryScreenAction {
  Categories category;
  BuildContext context;
  ReturnChosenCategoryAction(this.category, this.context);
}
