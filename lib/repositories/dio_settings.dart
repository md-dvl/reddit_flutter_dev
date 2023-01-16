import 'package:dio/dio.dart';

class DioSettings {
  DioSettings() {
    setup();
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://reddit.com/r/flutterdev/new.json',
      connectTimeout: 15000,
      receiveTimeout: 15000,
    ),
  );

  void setup() {
    final interceptors = dio.interceptors;
    interceptors.clear();

    final logInterceptors = LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    );

    interceptors.addAll([logInterceptors]);
  }
}
