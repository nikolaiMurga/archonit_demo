import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'archonit_demo_app.dart';
import 'data/db/db_client.dart';
import 'data/db/hive_db_client_impl.dart';
import 'data/db/persistence_helper.dart';
import 'data/db/shared_db_client_impl.dart';
import 'data/network/api_client.dart';
import 'data/network/api_client_dio_impl.dart';
import 'data/network/endpoints.dart';
import 'data/network/params.dart';
import 'data/repos/local_repo.dart';
import 'data/repos/network_repo.dart';
import 'data/mappers/currency_mapper.dart';
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

  final ApiClient apiClient = ApiClientDioImpl(dio, params);
  // final ApiClient apiClient = ApiClientHttpImpl(params);

  // DB
  final pref = await SharedPreferences.getInstance();
  final DbClient dbClient = SharedDbClientImpl(pref);

  // await PersistenceHelper.initHive();
  // final DbClient dbClient = HiveDbClientImpl();

  // MAPPERS
  final CurrencyMapper currencyMapper = CurrencyMapper();

  // REPOS
  final NetworkRepo networkRepo = NetworkRepo(apiClient, currencyMapper);
  final LocalRepo localRepo = LocalRepo(dbClient, currencyMapper);

  // USE CASES
  final CurrencyUseCase currencyUseCase = CurrencyUseCase(networkRepo, localRepo);

  runApp(
    MultiBlocProvider(
      providers: [
        RepositoryProvider<CurrencyUseCase>(create: (c) => currencyUseCase),
      ],
      child: const ArchonitDemoApp(),
    ),
  );
}
