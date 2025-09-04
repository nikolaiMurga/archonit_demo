import 'package:dio/dio.dart';


import '../../domain/mixins/dio_exception_mixin.dart';
import 'api_client.dart';

// class ApiClientDioImpl with DioExceptionMixin implements ApiClient {
//   final Dio _dio;
//
//   ApiClientDioImpl(this._dio);
//
//   // GET
//   @override
//   Future<Response> get({required String url}) async {
//     return await dioExceptionHandle(apiCall: _dio.get(url));
//   }
// }
