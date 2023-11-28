import 'package:places/data/repository/repositories.dart';
import 'package:places/database/database.dart';
import 'package:places/redux/action/search_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class SearchScreenMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is RemoveItemFromHistoryAction) {
      await action.context.read<AppDb>().removeHistory(action.id);
      searchRepository.history = await action.context.read<AppDb>().allHistory;
    }
    if (action is RemoveAllItemsFromHistory) {
      await action.context.read<AppDb>().removeAllHistory();
      searchRepository.history = await action.context.read<AppDb>().allHistory;
    }
    if (action is TapOnMiniCardSight) {
      if (!_isInHistory(action.title)) {
        await action.context
            .read<AppDb>()
            .addHistory(HistorysCompanion.insert(title: action.title));
        searchRepository.history =
            await action.context.read<AppDb>().allHistory;
      }
    }
    next(action);
  }

  bool _isInHistory(String name) {
    var stringHistory = <String>[];
    for (var h in searchRepository.history) {
      stringHistory.add(h.title);
    }
    return stringHistory.contains(name);
  }
}
