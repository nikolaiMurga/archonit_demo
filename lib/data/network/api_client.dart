// import 'package:dio/dio.dart';
import 'package:http/http.dart';

abstract class ApiClient {
  Future<Response> get({required String url});
}
