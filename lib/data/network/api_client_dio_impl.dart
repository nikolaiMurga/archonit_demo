import 'package:archonit_demo/recources%20/app_strings.dart';
import 'package:dio/dio.dart';
import '../../domain/models/error_model.dart';
import 'api_client.dart';

class ApiClientDioImpl implements ApiClient {
  final Dio _dio;

  ApiClientDioImpl(this._dio);

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

  Future<dynamic> _dioExceptionHandle({required Future<dynamic> apiCall}) async {
    try {
      final response = await apiCall;
      return response;
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  // GET
  @override
  Future<Response> get({required String url}) async {
    return await _dioExceptionHandle(apiCall: _dio.get(url));
  }
}
