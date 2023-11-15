import 'package:geolocator/geolocator.dart';
import 'package:places/data/model/location.dart';

class LocationService {
  final defLocation = const MoscowLocation();

  Future<Location> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return Location(lat: value.latitude, lon: value.longitude);
    }).catchError(
      (_) => defLocation,
    );
  }

  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}
