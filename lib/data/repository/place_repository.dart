import 'package:places/api/place_api.dart';
import 'package:places/data/model/place.dart';

class PlaceRepository {
  final placeApi = PlaceApi();
  List<Place> places = [];
  Future<void> loadPlaces() async {
    var p1 = Place(
        id: '0',
        lat: 52.40,
        lon: 13.05,
        name: 'Brandenburger Tor',
        urls: [
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Brandenburger_Tor_Potsdam_Stadtseite_2015.jpg/220px-Brandenburger_Tor_Potsdam_Stadtseite_2015.jpg'
        ],
        placeType: 'other',
        description: 'description');
    var p2 = Place(
        id: '1',
        lat: 52.40,
        lon: 14.05,
        name: 'Unscheinbar',
        urls: [
          'https://images.unsplash.com/photo-1572116469696-31de0f17cc34?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Q29ja3RhaWxiYXJ8ZW58MHx8MHx8fDA%3D'
        ],
        placeType: 'cafe',
        description: 'description');
    var p3 = Place(
        id: '2',
        lat: 54.40,
        lon: 13.05,
        name: 'Filmmuseum',
        urls: [
          'https://museen.de/imgbstr-9965701.jpg'
        ],
        placeType: 'museum',
        description: 'description');
    var p4 = Place(
        id: '3',
        lat: 55.40,
        lon: 14.05,
        name: 'Restaurant',
        urls: [
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Restaurant_Näsinneula.jpg/640px-Restaurant_Näsinneula.jpg'
        ],
        placeType: 'restaurant',
        description: 'description');
    var p5 = Place(
        id: '4',
        lat: 57.40,
        lon: 13.05,
        name: 'Babelsberg Park',
        urls: [
          'https://www.spsg.de/fileadmin/_processed_/c/8/csm_SPSG_ParkBabelsberg_AndreStiebitz_F0106184_A4_63e2286bfd.jpg'
        ],
        placeType: 'park',
        description: 'description');
    var p6 = Place(
        id: '5',
        lat: 53.40,
        lon: 13.05,
        name: 'Hotel',
        urls: [
          'https://www.usatoday.com/gcdn/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg'
        ],
        placeType: 'hotel',
        description: 'description');
    places = [p1,p2,p3,p4,p5,p6]; //await placeApi.loadPlaces();
  }

  Future<void> addPlace(Place newPlace) async {
    await placeApi.addPlace(newPlace);
  }
}
