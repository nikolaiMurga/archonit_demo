import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'archonit_demo_app.dart';
import 'data/network/api_client.dart';
import 'data/network/api_client_dio_impl.dart';
import 'data/network/api_licent_http_impl.dart';
import 'data/network/endpoints.dart';
import 'data/network/params.dart';
import 'data/repos/network_repo.dart';
import 'domain/mappers/currency_mapper.dart';
import 'domain/use_cases/currency_use_case.dart';
import 'resources/app_constants.dart';
import 'resources/app_strings.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  // API
  final Params params = Params();
  final BaseOptions baseOptions = BaseOptions(
    baseUrl: Endpoints.baseUrl,
    headers: params.getHeaders(token: dotenv.env[AppStrings.apiToken]),
    connectTimeout: AppConstants.connectTimeout,
    receiveTimeout: AppConstants.receiveTimeout,
    sendTimeout: AppConstants.sendTimeout,
  );
  final Dio dio = Dio(baseOptions);

  final ApiClient apiClient = ApiClientDioImpl(dio);
  // final ApiClient apiClient = ApiClientHttpImpl(params);

  // REPOS
  final NetworkRepo networkRepo = NetworkRepo(apiClient, params);

  // MAPPERS
  final CurrencyMapper currencyMapper = CurrencyMapper();

  // USE CASES
  final CurrencyUseCase currencyUseCase = CurrencyUseCase(networkRepo, currencyMapper);

  runApp(
    MultiBlocProvider(
      providers: [
        RepositoryProvider<CurrencyUseCase>(create: (c) => currencyUseCase),
      ],
      child: const ArchonitDemoApp(),
    ),
  );
}
