import 'package:dio/dio.dart';

class ApiErrorHandling {
  static String handleApiError(Object error) {
    if (error is DioException) {
      return switch (error.type) {
        DioExceptionType.badCertificate =>
          "Bad certificate error, please try again later!",
        DioExceptionType.badResponse =>
          "Bad response error, please try again later!",
        DioExceptionType.connectionTimeout =>
          "Connection timeout error, please try again later!",
        DioExceptionType.connectionError =>
          "Connection error, please try again later!",
        DioExceptionType.cancel => "Request canceled, please try again later!",
        DioExceptionType.unknown => "Unknown error, please try again later!",
        DioExceptionType.receiveTimeout =>
          "Receive timeout error, please try again later!",
        DioExceptionType.sendTimeout =>
          "Send timeout error, please try again later!",
      };
    }

    return error.toString();
  }
}
