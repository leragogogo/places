import 'package:places/data/model/categories.dart';

// Базовое состояние экрана добавления места.
abstract class AddSightScreenState {}

// Инициализирующее состояние экрана добавления места.
class AddSightScreenInitialState extends AddSightScreenState {}

// Основное состояние экрана добавления места.
class AddSightScreenMainState extends AddSightScreenState {
  List<int> images;
  Categories? category;
  String? name;
  double? lat;
  double? lon;
  String? details;
  bool isAllFieldsFilled;
  AddSightScreenMainState(this.images, this.category, this.name, this.lat,
      this.lon, this.details, this.isAllFieldsFilled);
}
