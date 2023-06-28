import 'package:places/api/place_api.dart';
import 'package:places/data/model/place.dart';

class PlaceRepository {
  final placeApi = PlaceApi();
  List<Place> places = [];
  Future<void> initPlaces() async {
    places = await placeApi.loadPlaces();
  }

  Future<void> addPlace(Place newPlace) async {
    await placeApi.addPlace(newPlace);
  }
}
