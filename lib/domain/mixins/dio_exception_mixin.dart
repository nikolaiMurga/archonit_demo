import 'package:dio/dio.dart';

import '../../recources /app_strings.dart';
import '../models/error_model.dart';

mixin DioExceptionMixin {
  ErrorModel _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ErrorModel(error: AppStrings.connectionTimeout);
      case DioExceptionType.sendTimeout:
        return ErrorModel(error: AppStrings.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return ErrorModel(error: AppStrings.receiveTimeout);
      case DioExceptionType.badResponse:
        return ErrorModel(error: AppStrings.serverTimeout);
      case DioExceptionType.cancel:
        return ErrorModel(error: AppStrings.requestCancelled);
      default:
        return ErrorModel(error: '${AppStrings.unknownError} ${e.message}');
    }
  }

  Future<dynamic> dioExceptionHandle({required Future<dynamic> apiCall}) async {
    try {
      final response = await apiCall;
      return response;
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }
}