import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  /// Private constructor to prevent instantiation
  DioFactory._();

  static late Dio _dio;

  static Dio getDio() {
    Duration duration = const Duration(seconds: 30);

    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.rawg.io/api/',
        connectTimeout: duration,
        receiveTimeout: duration,
        sendTimeout: duration,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add Logger to inspect data in Debug Mode
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ),
    );

    return _dio;
  }
}