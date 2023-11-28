import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/model/place.dart';
import 'package:places/redux/action/sight_list_screen_action.dart';
import 'package:places/redux/action/favourite_tab_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/sight_list_screen_state.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/add_sight_button.dart';
import 'package:places/ui/screen/widgets/network_error_widget.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SightListScreen();
}

class _SightListScreen extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SightListScreenState>(onInit: (store) {
      store.dispatch(LoadSightsAction(context));
    }, builder: (BuildContext context, SightListScreenState vm) {
      if (vm is SightListScreenLoadingState) {
        return _LoadingSightListScreen();
      } else if (vm is SightListScreenDataState) {
        return _LoadedSightListScreen(vm.places);
      } else if (vm is SightListScreenErrorState) {
        return _ErrorSightListScreen();
      }
      return Container();
    }, converter: (store) {
      return store.state.sightListScreenState;
    });
  }
}

class _ErrorSightListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NetworkErrorWidget(),
    );
  }
}

class _LoadingSightListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddNewSightButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: CircularProgressIndicator(color: AppColors.planButtonColor),
      ),
    );
  }
}

class _LoadedSightListScreen extends StatelessWidget {
  final List<Place> places;
  _LoadedSightListScreen(this.places);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddNewSightButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomScrollView(
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
              child: SearchSightBar(
                readOnly: true,
                onChanged: (value) {},
                onTap: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(OpenSearchScreenAction(context));
                },
                suffixIcon: IconButton(
                  icon: ImageIcon(
                    const AssetImage(AppAssets.filterAsset),
                    color: AppColors.planButtonColor,
                  ),
                  onPressed: () async {
                    StoreProvider.of<AppState>(context)
                        .dispatch(OpenFiltersScreenAction(context));
                  },
                ),
                controller: null,
              ),
            ),
          ),
          // Основной список
          if (MediaQuery.of(context).orientation == Orientation.portrait)
            _SightListPortrait(filteredPlaces: places)
          else
            _SightListLandscape(filteredPlaces: places),
        ],
      ),
    );
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
            child: SightCard(
              place: filteredPlaces[index],
              addToFavourites: () {
                StoreProvider.of<AppState>(context).dispatch(
                    AddSightToFavouriteAction(
                        filteredPlaces[index], filteredPlaces, context));
              },
              removeFromFavorites: () {
                StoreProvider.of<AppState>(context).dispatch(
                    RemoveFavouritePlaceAction(filteredPlaces[index], context));
              },
              isMapCard: false,
              buildRoute: null,
            ),
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
              SightCard(
                place: filteredPlaces[index],
                addToFavourites: () {
                  StoreProvider.of<AppState>(context).dispatch(
                      AddSightToFavouriteAction(
                          filteredPlaces[index], filteredPlaces, context));
                },
                removeFromFavorites: () {
                  StoreProvider.of<AppState>(context).dispatch(
                      RemoveFavouritePlaceAction(
                          filteredPlaces[index], context));
                },
                isMapCard: false,
                buildRoute: null,
              ),
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
