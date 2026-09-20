import 'package:dio/dio.dart';
import 'api_error_model.dart';

class ApiErrorHandler implements Exception {
  final ApiErrorModel apiErrorModel;

  ApiErrorHandler.handle(dynamic error)
      : apiErrorModel = _parseError(error);

  static ApiErrorModel _parseError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: 'Connection timeout with the server.');
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message: 'Send timeout in connection with server.');
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: 'Receive timeout in connection with server.');
        case DioExceptionType.badResponse:
          return _handleBadResponse(error.response);
        case DioExceptionType.cancel:
          return ApiErrorModel(message: 'Request to server was cancelled.');
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: 'No internet connection. Please check your network.');
        case DioExceptionType.badCertificate:
          return ApiErrorModel(message: 'Security certificate error.');
        case DioExceptionType.unknown:
        default:
          return ApiErrorModel(message: 'Unexpected network error occurred.');
      }
    } else {
      return ApiErrorModel(message: error.toString());
    }
  }

  static ApiErrorModel _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    // معالجة حسب كود الاستجابة HTTP
    switch (statusCode) {
      case 400:
      case 401:
      case 403:
      case 422:
        return ApiErrorModel.fromJson(data);
      case 404:
        return ApiErrorModel(message: 'The requested resource was not found.', statusCode: 404);
      case 500:
      case 502:
      case 503:
        return ApiErrorModel(message: 'Server error. Please try again later.', statusCode: statusCode);
      default:
        return ApiErrorModel.fromJson(data);
    }
  }
}