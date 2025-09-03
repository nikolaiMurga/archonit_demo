import 'package:archonit_demo/data/network/endpoints.dart';
import 'package:archonit_demo/recources%20/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'archonit_demo_app.dart';
import 'data/network/api_client.dart';
import 'data/network/api_client_dio_impl.dart';
import 'data/network/api_licent_http_impl.dart';
import 'data/network/params.dart';
import 'data/repos/network_repo.dart';

void main() async {
  runApp(const ArchonitDemoApp());
  await dotenv.load(fileName: ".env");

  // API
  final Params params = Params();
  // final Dio dio = Dio();
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: params.getHeaders(token: dotenv.env[AppStrings.apiToken]),
    ),
  );

  final ApiClient apiClient = ApiClientDioImpl(dio);
  // final ApiClient apiClient = ApiClientHttpImpl(params);

  // REPOS
  final NetworkRepo networkRepo = NetworkRepo(apiClient);
}
