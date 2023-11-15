import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/model/map_point.dart';
import 'package:places/data/model/place.dart';
import 'package:places/methods.dart';
import 'package:places/redux/action/map_screen_action.dart';
import 'package:places/redux/action/sight_list_screen_action.dart';
import 'package:places/redux/state/app_state.dart';
import 'package:places/redux/state/map_screen_state.dart';
import 'package:places/ui/screen/res/app_assets.dart';
import 'package:places/ui/screen/res/app_colors.dart';
import 'package:places/ui/screen/res/app_strings.dart';
import 'package:places/ui/screen/widgets/add_sight_button.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:places/ui/screen/widgets/sight_card.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final mapControllerCompleter = Completer<YandexMapController>();

  List<PlacemarkMapObject> _getPlacemarkObjects(
      List<MapPoint> mapPoints, Point? userLocation) {
    var placemarks = mapPoints
        .map((mapPoint) => PlacemarkMapObject(
              onTap: (mapObject, point) {
                StoreProvider.of<AppState>(context).dispatch(
                    ClickOnMapPointAction(mapPoint, userLocation, mapPoints));
              },
              opacity: 1,
              mapId: MapObjectId('$mapPoint'),
              point: Point(
                  latitude: mapPoint.latitude, longitude: mapPoint.longitude),
              icon: mapPoint.isClicked
                  ? PlacemarkIcon.single(PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                          AppAssets.chosenPlacemarkAsset),
                      scale: 3,
                    ))
                  : PlacemarkIcon.single(PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage(
                          AppAssets.unchosenPlacemarkAsset),
                      scale: 3,
                    )),
            ))
        .toList();
    if (userLocation != null) {
      placemarks.add(PlacemarkMapObject(
          mapId: MapObjectId('$userLocation'),
          point: userLocation,
          opacity: 1,
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(AppAssets.userLocationAsset),
            scale: 2,
          ))));
    }

    return placemarks;
  }

  MapPoint? isAnyMapPointClicked(List<MapPoint> mapPoints) {
    for (final mapPoint in mapPoints) {
      if (mapPoint.isClicked == true) {
        return mapPoint;
      }
    }
    return null;
  }

  Place findPlaceByMapPoint(MapPoint mapPoint) {
    var fp = getFilteredPlaces();
    for (final place in fp) {
      if ((place.name == mapPoint.name) &&
          (place.lat == mapPoint.latitude) &&
          (place.lon == mapPoint.longitude)) {
        return place;
      }
    }
    return fp[0];
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MapScreenState>(onInit: (store) {
      store.dispatch(InitMapPointsAction());
    }, builder: (BuildContext context, MapScreenState vm) {
      if (vm is MapScreenMainState) {
        return Scaffold(
            appBar: AppBar(
              title: const Center(
                child: Text(
                  AppStrings.mapTitle,
                ),
              ),
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
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
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: isAnyMapPointClicked(vm.mapPonts) != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FloatingActionButton(
                                heroTag: null,
                                elevation: 0,
                                onPressed: () {
                                  StoreProvider.of<AppState>(context)
                                      .dispatch(UpdateMapPointsAction(context));
                                },
                                child: ImageIcon(
                                  AssetImage(AppAssets.refreshAsset),
                                  color: Theme.of(context).canvasColor,
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              FloatingActionButton(
                                heroTag: null,
                                elevation: 0,
                                onPressed: () async {
                                  StoreProvider.of<AppState>(context).dispatch(
                                      ShowUserLocationAction(
                                          vm.mapPonts, mapControllerCompleter));
                                  //_initPermission().ignore();
                                },
                                child: ImageIcon(
                                  AssetImage(
                                    AppAssets.geolocationAsset,
                                  ),
                                  color: Theme.of(context).canvasColor,
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          SightCard(
                            place: findPlaceByMapPoint(
                                isAnyMapPointClicked(vm.mapPonts)!),
                            addToFavourites: () {},
                            removeFromFavorites: () {},
                            isMapCard: true,
                            buildRoute: () {
                              StoreProvider.of<AppState>(context).dispatch(
                                  BuildRouteAction(
                                      context,
                                      findPlaceByMapPoint(
                                          isAnyMapPointClicked(vm.mapPonts)!)));
                              StoreProvider.of<AppState>(context).dispatch(
                                  AddSightToVisitedAction(
                                      findPlaceByMapPoint(
                                          isAnyMapPointClicked(vm.mapPonts)!),
                                      context));
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            heroTag: null,
                            elevation: 0,
                            onPressed: () {
                              StoreProvider.of<AppState>(context)
                                  .dispatch(UpdateMapPointsAction(context));
                            },
                            child: ImageIcon(
                              AssetImage(AppAssets.refreshAsset),
                              color: Theme.of(context).canvasColor,
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          AddNewSightButton(),
                          FloatingActionButton(
                            heroTag: null,
                            elevation: 0,
                            onPressed: () async {
                              StoreProvider.of<AppState>(context).dispatch(
                                  ShowUserLocationAction(
                                      vm.mapPonts, mapControllerCompleter));
                            },
                            child: ImageIcon(
                              AssetImage(
                                AppAssets.geolocationAsset,
                              ),
                              color: Theme.of(context).canvasColor,
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
              ),
            ),
            body: Container(
                padding: EdgeInsets.only(top: 16),
                child: YandexMap(
                  onMapCreated: (controller) async {
                    mapControllerCompleter.complete(controller);
                  },
                  mapObjects:
                      _getPlacemarkObjects(vm.mapPonts, vm.userLocation),
                )));
      }
      return Container();
    }, converter: (store) {
      return store.state.mapScreenState;
    });
  }
}
