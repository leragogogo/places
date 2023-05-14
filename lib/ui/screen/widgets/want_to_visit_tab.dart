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
            child: Column(
              children: wantToVisit
                  .asMap()
                  .entries
                  .map((i) => VisitingSightCard(
                        sight: i.value,
                        deleteFromList: () {
                          setState(() {
                            deleteWantToVisitedSight(i.value);
                          });
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

  void deleteWantToVisitedSight(Sight sight) {
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
  }
}
