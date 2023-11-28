import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/repositories.dart';
import 'package:places/database/database.dart';
import 'package:places/redux/action/search_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/search_screen_state.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_appbar.dart';
import 'package:places/ui/screen/widgets/sight_details.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatefulWidget {
  final searchField = TextEditingController();
  SightSearchScreen({super.key});

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  late AppDb _db;

  @override
  void initState() {
    super.initState();
    _db = context.read<AppDb>();
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: SightAppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.canvasColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: SearchSightBar(
            readOnly: false,
            onChanged: (value) {
              StoreProvider.of<AppState>(context).dispatch(
                  SearchTextWasUpdatedAction(value, searchRepository.history));
            },
            onTap: () {},
            suffixIcon: IconButton(
              icon: Icon(
                CupertinoIcons.clear_circled_solid,
                color: theme.canvasColor,
              ),
              onPressed: () {
                widget.searchField.clear();
                StoreProvider.of<AppState>(context).dispatch(
                    SearchTextWasUpdatedAction('', searchRepository.history));
              },
            ),
            controller: widget.searchField,
          ),
        ),
        body: StoreConnector<AppState, SearchScreenState>(onInit: (store) {
          return store.dispatch(InitSearchScreenAction());
        }, builder: (BuildContext context, SearchScreenState vm) {
          if (vm is SearchSreenErrorState) {
            return _EmptyScreen();
          } else if (vm is SearchScreenHistoryState) {
            var historyWidgets = <Widget>[];
            for (var i = 0; i < vm.history.length; i++) {
              historyWidgets.add(_HistoryTile(vm.history[i].title, () {
                StoreProvider.of<AppState>(context).dispatch(
                    RemoveItemFromHistoryAction(context, vm.history[i].id));
              }));
            }
            return _HistoryScreen(historyWidgets, () {
              StoreProvider.of<AppState>(context)
                  .dispatch(RemoveAllItemsFromHistory(
                context,
              ));
            });
          } else if (vm is SearchScreenDataState) {
            var searchList = <Widget>[];
            for (int i = 0; i < vm.places.length; i++) {
              searchList.add(_MiniSightCard(vm.places[i], () {
                StoreProvider.of<AppState>(context).dispatch(TapOnMiniCardSight(
                  context,
                  vm.places[i].name,
                ));
                showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  builder: (_) => SightDetailsScreen(vm.places[i]),
                );
              }));
            }
            return SingleChildScrollView(child: Column(children: searchList));
          }
          return Container();
        }, converter: (store) {
          return store.state.searchScreenState;
        }));
  }

  Future<void> _loadHistory() async {
    searchRepository.history = await _db.allHistory;
  }
}

class _HistoryScreen extends StatelessWidget {
  final List<Widget> history;
  final VoidCallback onPressed;
  const _HistoryScreen(this.history, this.onPressed, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final widgets = <Widget>[];

    if (history.isNotEmpty) {
      widgets
        ..add(const SizedBox(
          height: 38,
        ))
        ..add(Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            AppStrings.historyText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColorDark,
              fontSize: 12,
            ),
          ),
        ))
        ..addAll(history)
        ..add(
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                AppStrings.clearHistoryText,
                style: TextStyle(
                  color: AppColors.planButtonColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
    }

    return SingleChildScrollView(
      child: Column(
        children: widgets,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const _HistoryTile(this.text, this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: Text(
          text,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.primaryColorDark,
            fontSize: 16,
          ),
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          CupertinoIcons.clear,
          color: theme.primaryColorDark,
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return text;
  }
}

class _MiniSightCard extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;
  const _MiniSightCard(this.place, this.onTap, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: SizedBox(
        width: 56,
        height: 56,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: place.urls.isEmpty
              ? Container(
                  color: theme.primaryColor,
                  alignment: Alignment.center,
                  child: Center(
                    child: Image.asset(
                      AppAssets.placeholderAsset,
                      width: 100,
                      height: 100,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: place.urls[0],
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                  errorWidget: (context, url, dynamic error) => Container(
                    color: theme.primaryColor,
                    alignment: Alignment.center,
                    child: Center(
                      child: Image.asset(
                        AppAssets.placeholderAsset,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
        ),
      ),
      title: Text(
        place.name,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.canvasColor,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        place.beatifulType,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.primaryColorDark,
          fontSize: 14,
        ),
      ),
      onTap: onTap,
    );
  }
}

class _EmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Icon(
            CupertinoIcons.search,
            size: 64,
            color: theme.primaryColorDark,
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            AppStrings.emptySearch,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColorDark,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            AppStrings.emptySearch2,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColorDark,
              fontSize: 14,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
