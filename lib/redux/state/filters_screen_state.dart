import 'package:flutter/material.dart';
import 'package:places/data/model/filter_item.dart';
import 'package:places/data/model/place.dart';

// Базовое состояние экрана фильтров.
abstract class FiltersScreenState{}

// Инициализирующее состояние экрана фильтров.
class FiltersScreenInitialState extends FiltersScreenState{}

// Состояние экрана фильтров когда хотя бы одна категория выбрана.
class AtLeastOneCategoryChosenState extends FiltersScreenState{
  List<FilterItem> chosenCategories;
  RangeValues radius;
  List<Place> result;
  AtLeastOneCategoryChosenState(this.chosenCategories,this.radius,this.result);
}

// Состояние экрана фильтров когда ни одна категория выбрана.
class NoOneCategoryChosenState extends FiltersScreenState{
  RangeValues radius;
  NoOneCategoryChosenState(this.radius);
}