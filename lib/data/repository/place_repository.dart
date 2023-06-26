import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';

class PlaceRepository {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://test-backend-flutter.surfstudio.ru',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
    sendTimeout: const Duration(milliseconds: 5000),
  ));

  void addInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint(
            'Запрос: ${options.method} ${options.path} ${options.queryParameters}',
          );

          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('Ответ получен ${response.data} ');

          return handler.next(response);
        },
        onError: (e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  Future<List<Place>> loadPlaces() async {
    addInterceptors();
    final Response response = await dio.get<String>(
      '/place',
    );
    if (response.statusCode != 200) {
      throw Exception('http error. Error code ${response.statusCode}');
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
    addInterceptors();
    final Response response =
        await dio.post<String>('/place', data: jsonEncode(newPlace));

    if (response.statusCode != 200) {
      throw Exception('http error. Error code ${response.statusCode}');
    }

    return;
  }
}
