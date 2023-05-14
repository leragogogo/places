import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/visited_tab.dart';
import 'package:places/ui/screen/widgets/want_to_visit_tab.dart';

class VisitingScreen extends StatelessWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
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
                    color: theme.canvasColor,
                  ),
                  tabs: const [
                    _VisitingTab(
                      text: AppStrings.firstTabFavouriteScreenText,
                    ),
                    _VisitingTab(
                      text: AppStrings.secondTabFavouriteScreenText,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            WantToVisitTab(),
            VisitedTab(),
          ],
        ),
      ),
    );
  }
}

class _VisitingTab extends StatelessWidget {
  final String text;

  const _VisitingTab({required this.text, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Align(
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
