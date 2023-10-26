import 'package:flutter/material.dart';
import 'package:places/database/database.dart';

/// Базовый класс действий с экраном поиска.
abstract class SearchScreenAction {}

// Инициализация
class InitSearchScreenAction extends SearchScreenAction {}

/// Обновление текста поиска.
class SearchTextWasUpdatedAction extends SearchScreenAction {
  String searchText;
  List<History> history;
  SearchTextWasUpdatedAction(this.searchText, this.history);
}

/// Удаление из истории поиска.
class RemoveItemFromHistoryAction extends SearchScreenAction {
  BuildContext context;
  int id;
  RemoveItemFromHistoryAction(
    this.context,
    this.id,
  );
}

// Нажатие на мини карточку.
class TapOnMiniCardSight extends SearchScreenAction {
  BuildContext context;
  String title;
  TapOnMiniCardSight(this.context, this.title);
}

/// Удаление всей истории поиска.
class RemoveAllItemsFromHistory extends SearchScreenAction {
  BuildContext context;
  RemoveAllItemsFromHistory(
    this.context,
  );
}
