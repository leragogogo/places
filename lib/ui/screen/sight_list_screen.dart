import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:places/data/interactor/filter_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data_providers/filter_provider.dart';
import 'package:places/ui/screen/add_sight_screen.dart';
import 'package:places/ui/screen/filters_screen.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/sight_search_screen.dart';
import 'package:places/ui/screen/widgets/network_error_widget.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/widgets/store.dart';
import 'package:provider/provider.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SightListScreen();
}

class _SightListScreen extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _AddNewSightButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Observer(builder: (_) {
          return store.isRequestDoneWithError
              ? NetworkErrorWidget()
              : Stack(
                  children: [
                    store.filteredPlaces.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(color: AppColors.planButtonColor),
                          )
                        : CustomScrollView(
                            slivers: [
                              // AppBar
                              SliverPersistentHeader(
                                delegate: _SliverSightAppBar(),
                                pinned: true,
                              ),
                              // Поисковая строка
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16),
                                  child: SearchBar(
                                    onChanged: (value) {},
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute<SightSearchScreen>(
                                          builder: (context) => SightSearchScreen(),
                                        ),
                                      );
                                    },
                                    controller: null,
                                  ),
                                ),
                              ),
                              // Основной список
                              if (MediaQuery.of(context).orientation == Orientation.portrait)
                                _SightListPortrait(
                                  filteredPlaces: store.filteredPlaces,
                                )
                              else
                                _SightListLandscape(
                                  filteredPlaces: store.filteredPlaces,
                                ),
                            ],
                          ),
                  ],
                );
        }));
  }
}

class _SightListPortrait extends StatelessWidget {
  final List<Place> filteredPlaces;

  const _SightListPortrait({required this.filteredPlaces});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SightCard(filteredPlaces[index]),
          );
        },
        childCount: filteredPlaces.length,
      ),
    );
  }
}

class _SightListLandscape extends StatelessWidget {
  final List<Place> filteredPlaces;

  const _SightListLandscape({required this.filteredPlaces});
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              SightCard(filteredPlaces[index]),
            ],
          );
        },
        childCount: filteredPlaces.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 210,
        crossAxisCount: 2,
      ),
    );
  }
}

class _AddNewSightButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 177,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.gradientStartColor,
            AppColors.planButtonColor,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<AddSightScreen>(
              builder: (context) => const AddSightScreen(),
            ),
          );
        },
        child: Center(
          child: Row(
            children: const [
              Icon(Icons.add),
              Text(
                AppStrings.newSightText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverSightAppBar extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 100;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final progress = shrinkOffset / maxExtent;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      color: theme.appBarTheme.backgroundColor,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.lerp(
        Alignment.bottomLeft,
        Alignment.bottomCenter,
        progress,
      ),
      child: Text(
        progress == 0 ? AppStrings.titleText2 : AppStrings.titleText,
        style: TextStyle.lerp(
          theme.textTheme.bodyLarge?.copyWith(color: theme.canvasColor),
          theme.textTheme.bodyLarge?.copyWith(
            color: theme.canvasColor,
            fontSize: 18,
          ),
          progress,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
