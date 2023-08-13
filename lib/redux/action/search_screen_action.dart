import 'package:places/data/interactor/search_interactor.dart';

/// Базовый класс действий с экраном поиска.
abstract class SearchScreenAction {}

/// Обновление текста поиска.
class SearchTextWasUpdatedAction extends SearchScreenAction {
  String searchText;
  SearchInteractor searchInteractor;
  List<String> history;
  SearchTextWasUpdatedAction(
      this.searchText, this.searchInteractor, this.history);
}

/// Удаление из истории поиска.
class RemoveItemFromHistoryAction extends SearchScreenAction {
  List<String> history;
  final int i;
  RemoveItemFromHistoryAction(this.i, this.history);
}

/// Удаление всей истории поиска.
class RemoveAllItemsFromHistory extends SearchScreenAction {
  List<String> history;
  RemoveAllItemsFromHistory(this.history);
}
