import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places/data_providers/want_to_visit_provider.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/empty_screen.dart';
import 'package:places/ui/screen/widgets/sight_card_visited.dart';
import 'package:provider/provider.dart';

class WantToVisitTab extends StatefulWidget {
  const WantToVisitTab({super.key});

  @override
  State<StatefulWidget> createState() => _WantToVisitTabState();
}

class _WantToVisitTabState extends State<WantToVisitTab> {
  bool isWantToVisitEmpty = false;

  List<Sight> wantToVisit = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    wantToVisit = Provider.of<WantToVisitProvider>(context).wantToVisit;
    isWantToVisitEmpty =
        Provider.of<WantToVisitProvider>(context).isWantToVisitEmpty;

    return isWantToVisitEmpty
        ? const EmptyScreen(
            path: AppAssets.wantToVisitedEmpty,
            text: AppStrings.wantToVisetedEmptyText,
          )
        : Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: ReorderableListView(
              physics: Platform.isAndroid
                  ? const ClampingScrollPhysics()
                  : const BouncingScrollPhysics(),
              proxyDecorator: (child, index, animation) => Material(
                type: MaterialType.transparency,
                child: child,
              ),
              onReorder: _updateWantToVisitList,
              children: wantToVisit
                  .asMap()
                  .entries
                  .map((i) => VisitingSightCard(
                        key: ObjectKey(i.value),
                        sight: i.value,
                        deleteFromList: () {
                          _deleteWantToVisitedSight(i.value);
                        },
                        lowerText: Text(
                          AppStrings.wantToVisitText,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.planButtonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          );
  }

  void _updateWantToVisitList(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = wantToVisit.removeAt(oldIndex);
      wantToVisit.insert(newIndex, item);
    });
  }

  void _deleteWantToVisitedSight(Sight sight) {
    setState(() {
      var ind = 0;
      for (var i = 0; i < wantToVisit.length; i++) {
        if (wantToVisit[i] == sight) {
          ind = i;
        }
      }
      wantToVisit.removeAt(ind);
      isWantToVisitEmpty = wantToVisit.isEmpty;
      Provider.of<WantToVisitProvider>(context, listen: false).changeState(
        newWantToVisit: wantToVisit,
        newIsWantToVisitEmpty: isWantToVisitEmpty,
      );
    });
  }
}
