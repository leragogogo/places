import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/screen/res/app_api_urls.dart';

class DioConfigurators {
  static final dio = Dio(BaseOptions(
    baseUrl: AppApiUrls.backendUrl,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
    sendTimeout: const Duration(milliseconds: 5000),
  ));

  static void addInterceptors() {
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
}
