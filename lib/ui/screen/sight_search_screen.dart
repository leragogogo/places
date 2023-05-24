import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data_providers/field_empty_provider.dart';
import 'package:places/data_providers/history_provider.dart';
import 'package:places/data_providers/search_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_appbar.dart';
import 'package:places/ui/screen/widgets/sight_details.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatefulWidget {
  final List<Sight> mocksWithFilters;
  final searchField = TextEditingController();
  SightSearchScreen({required this.mocksWithFilters, super.key});

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  List<Widget> searchList = [];
  List<Widget> history = [];
  bool isFieldEmpty = true;

  @override
  Widget build(BuildContext context) {
    searchList = Provider.of<SearchProvider>(context).searchList;
    history = Provider.of<HistoryProvider>(context).history;
    isFieldEmpty = Provider.of<FieldEmptyProvider>(context).isFieldEmpty;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: SightAppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: theme.canvasColor,
          ),
          onPressed: () {
            searchList = [];
            history = [];
            isFieldEmpty = true;
            Provider.of<SearchProvider>(context, listen: false).changeState(
              newSearchList: searchList,
            );
            Provider.of<HistoryProvider>(context, listen: false).changeState(
              newHistory: history,
            );
            Provider.of<FieldEmptyProvider>(context, listen: false).changeState(
              newIsFieldEmpty: isFieldEmpty,
            );
            Navigator.pop(context);
          },
        ),
        bottom: SearchBar(
          readOnly: false,
          onChanged: (value) {
            isFieldEmpty = value.isEmpty;
            Provider.of<FieldEmptyProvider>(context, listen: false).changeState(
              newIsFieldEmpty: isFieldEmpty,
            );
            searchList = [];
            for (final mock in widget.mocksWithFilters) {
              if (mock.name.toLowerCase().contains(value.toLowerCase())) {
                searchList
                  ..add(_MiniSightCard(
                    mock,
                    () {
                      history
                        ..add(_HistoryTile(mock.name, () {
                          final index = findWidget(mock.name);
                          history
                            ..removeAt(index)
                            ..removeAt(index);
                          Provider.of<HistoryProvider>(context, listen: false)
                              .changeState(
                            newHistory: history,
                          );
                        }))
                        ..add(const Divider(
                          thickness: 1,
                          indent: 16,
                          endIndent: 16,
                        ));
                      Provider.of<HistoryProvider>(context, listen: false)
                          .changeState(
                        newHistory: history,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute<SightDetailsScreen>(
                          builder: (context) => SightDetailsScreen(
                            mock,
                          ),
                        ),
                      );
                    },
                  ))
                  ..add(const Divider(
                    thickness: 1,
                    indent: 88,
                  ));
              }
            }
            Provider.of<SearchProvider>(context, listen: false).changeState(
              newSearchList: searchList,
            );
          },
          onTap: () {},
          suffixIcon: IconButton(
            icon: Icon(
              CupertinoIcons.clear_circled_solid,
              color: theme.canvasColor,
            ),
            onPressed: clearText,
          ),
          controller: widget.searchField,
        ),
      ),
      body: isFieldEmpty
          ? _HistoryScreen(
              history,
              () {
                history = [];
                Provider.of<HistoryProvider>(context, listen: false)
                    .changeState(
                  newHistory: history,
                );
              },
            )
          : searchList.isEmpty
              ? _EmptyScreen()
              : SingleChildScrollView(child: Column(children: searchList)),
      resizeToAvoidBottomInset: true,
    );
  }

  int findWidget(String name) {
    var ind = 0;
    for (var i = 0; i < history.length; i++) {
      final cur = history[i];
      if (cur is _HistoryTile) {
        if (cur.text == name) {
          ind = i;
        }
      }
    }

    return ind;
  }

  void clearText() {
    searchList = [];
    Provider.of<SearchProvider>(context, listen: false).changeState(
      newSearchList: searchList,
    );
    isFieldEmpty = true;
    Provider.of<FieldEmptyProvider>(context, listen: false).changeState(
      newIsFieldEmpty: isFieldEmpty,
    );
    widget.searchField.clear();
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
      leading: Text(
        text,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.primaryColorDark,
          fontSize: 16,
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
  final Sight sight;
  final VoidCallback onTap;
  const _MiniSightCard(this.sight, this.onTap, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: SizedBox(
        width: 56,
        height: 56,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Image.network(
            sight.images[0],
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    : const CupertinoActivityIndicator(),
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(
        sight.name,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.canvasColor,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        sight.type.name,
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
