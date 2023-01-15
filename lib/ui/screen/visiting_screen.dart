import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/sight_card_visited.dart';
import 'package:places/ui/screen/widgets/sight_card_want_to_visited.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VisitingScreen();
}

class _VisitingScreen extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              AppStrings.favouriteButtonText,
            ),
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
                TabBar(
                  overlayColor: MaterialStateProperty.all(
                    theme.bottomNavigationBarTheme.backgroundColor,
                  ),
                  unselectedLabelColor: theme.primaryColorDark,
                  labelColor: theme.primaryColorLight,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: theme.backgroundColor,
                  ),
                  tabs: [
                    Tab(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Align(
                          child: Text(
                            AppStrings.firstTabFavouriteScreenText,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Align(
                          child: Text(
                            AppStrings.secondTabFavouriteScreenText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body:
            // пустые экраны
            /*TabBarView(
          children: [
            _EmptyScreen(AppAssets.wantToVisitedEmpty,AppStrings.wantToVisetedEmptyText),
            _EmptyScreen(AppAssets.visitedEmpty,AppStrings.visitedEmptyText),
          ],
        ),*/
            TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SightCardWantToVisited(mocks[0]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SightCardVisited(mocks[1]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyScreen extends StatelessWidget {
  final String path;
  final String text;

  const _EmptyScreen(this.path, this.text);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            path,
            height: 64,
            width: 64,
            color: theme.primaryColorDark,
          ),
          const SizedBox(height: 32),
          Text(
            AppStrings.emptyText,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
