import 'package:places/data/model/map_point.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract class MapScreenState{}

class MapScreenInitialState extends MapScreenState{}

class MapScreenMainState extends MapScreenState{
  List<MapPoint> mapPonts;
  Point? userLocation;
  MapScreenMainState(this.mapPonts,this.userLocation);
}