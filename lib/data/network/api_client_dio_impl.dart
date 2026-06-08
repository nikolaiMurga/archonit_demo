import 'package:archonit_demo/core/injection.dart';
import 'package:archonit_demo/data/network/api_client.dart';
import 'package:archonit_demo/data/network/endpoints.dart';
import 'package:archonit_demo/data/network/params.dart';
import 'package:archonit_demo/domain/models/error_model.dart';
import 'package:archonit_demo/resources/app_constants.dart';
import 'package:archonit_demo/resources/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClientDioImpl implements ApiClient {
  ApiClientDioImpl();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
    headers: getIt<Params>().getHeaders(token: dotenv.env[AppStrings.apiToken]),
    connectTimeout: AppConstants.connectTimeout,
    receiveTimeout: AppConstants.receiveTimeout,
    sendTimeout: AppConstants.sendTimeout,
  ));

  ErrorModel _mapDioException(DioException e) {
    ErrorModel badResponseHandle() {
      // from response
      final data = e.response?.data;

      // from response with model
      if (data is Map<String, dynamic>) {
        try {
          return ErrorModel.fromJson(data);
        } catch (_) {
          return ErrorModel(message: AppStrings.invalidResponse);
        }
      }
      return ErrorModel(message: AppStrings.invalidResponse);

      //manual
      // final statusCode = e.response?.statusCode;
      // switch (statusCode) {
      //   case 400:
      //     return ErrorModel(message: AppStrings.badRequest);
      //   case 401:
      //     return ErrorModel(message: AppStrings.unauthorized);
      //   case 403:
      //     return ErrorModel(message: AppStrings.forbidden);
      //   case 404:
      //     return ErrorModel(message: AppStrings.notFound);
      //   case 500:
      //     return ErrorModel(message: AppStrings.serverError);
      //   default:
      //     return ErrorModel(message: AppStrings.unknownError);
      // }
    }

    switch (e.type) {
      case DioExceptionType.badResponse:
        return badResponseHandle();
      case DioExceptionType.connectionTimeout:
        return ErrorModel(message: AppStrings.connectionTimeout);
      case DioExceptionType.sendTimeout:
        return ErrorModel(message: AppStrings.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return ErrorModel(message: AppStrings.receiveTimeout);
      case DioExceptionType.cancel:
        return ErrorModel(message: AppStrings.requestCancelled);
      default:
        return ErrorModel(message: '${AppStrings.unknownError}: ${e.message}');
    }
  }

  Future<Response> _dioExceptionHandle({required Future<dynamic> apiCall}) async {
    try {
      final resp = await apiCall;
      return resp;
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  // GET
  @override
  Future<dynamic> get({required String endpoint, required Map<String, dynamic> queryParams}) async {
    final resp = await _dioExceptionHandle(apiCall: _dio.get(endpoint, queryParameters: queryParams));
    return resp.data;
  }
}
