import 'package:places/data/model/categories.dart';

// Базовое состояние экрана выбора категории для нового места.
abstract class ChoosingCategoryScreenState {}

// Инициализирующее состояние экрана выбора категории для нового места.
class ChoosingCategoryScreenInitialState extends ChoosingCategoryScreenState {}

// Основное состояние экрана выбора категории для нового места.
class ChoosingCategoryScreenMainState extends ChoosingCategoryScreenState {
  Categories? category;
  bool isButtonDisabled;
  ChoosingCategoryScreenMainState(this.category, this.isButtonDisabled);
}
