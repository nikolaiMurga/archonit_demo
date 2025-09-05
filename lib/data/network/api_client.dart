import 'package:dio/dio.dart';

abstract class ApiClient {
  Future<dynamic> get({required String url});
}
