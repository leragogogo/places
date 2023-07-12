import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:places/configurators/dio_configurator.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/network_exception.dart';

class PlaceApi {
  Future<List<Place>> loadPlaces() async {
    DioConfigurators.addInterceptors();
    final Response response = await DioConfigurators.dio.get<String>(
      '/place',
    );
    if (response.statusCode != 200) {
      throw NetworkException(
        queryPath: '/place',
        error: '${response.statusCode} ${response.statusMessage}',
      );
    }

    return parsePlaces(response.data.toString());
  }

  List<Place> parsePlaces(String json) {
    final listJson = jsonDecode(json) as List;

    return listJson
        .map((dynamic placeJson) =>
            Place.fromJson(placeJson as Map<String, dynamic>))
        .toList();
  }

  Future<void> addPlace(Place newPlace) async {
    DioConfigurators.addInterceptors();
    final Response response = await DioConfigurators.dio
        .post<String>('/place', data: jsonEncode(newPlace));

    if (response.statusCode != 200) {
      throw NetworkException(
        queryPath: '/place',
        error: '${response.statusCode} ${response.statusMessage}',
      );
    }

    return;
  }
}
