import 'package:flutter/material.dart';
import 'package:places/data_providers/visited_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/empty_screen.dart';
import 'package:places/ui/screen/widgets/sight_card_visited.dart';
import 'package:provider/provider.dart';

class VisitedTab extends StatefulWidget {
  const VisitedTab({super.key});

  @override
  State<StatefulWidget> createState() => _VisitedTabState();
}

class _VisitedTabState extends State<VisitedTab> {
  bool isVisitedEmpty = false;

  List<Sight> visited = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    visited = Provider.of<VisitedProvider>(context).visited;
    isVisitedEmpty = Provider.of<VisitedProvider>(context).isVisitedEmpty;

    return isVisitedEmpty
        ? const EmptyScreen(
            path: AppAssets.visitedEmpty,
            text: AppStrings.visitedEmptyText,
          )
        : Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: visited
                  .asMap()
                  .entries
                  .map((i) => VisitingSightCard(
                        sight: i.value,
                        deleteFromList: () {
                          setState(() {
                            deleteVisitedSight(i.value);
                          });
                        },
                        lowerText: Text(
                          AppStrings.visitedText,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.primaryColorDark,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
  }

  void deleteVisitedSight(Sight sight) {
    var ind = 0;
    for (var i = 0; i < visited.length; i++) {
      if (visited[i] == sight) {
        ind = i;
      }
    }
    visited.removeAt(ind);
    isVisitedEmpty = visited.isEmpty;
    Provider.of<VisitedProvider>(context, listen: false).changeState(
      newIsVisitedEmpty: isVisitedEmpty,
      newVisited: visited,
    );
  }
}
