import 'package:archonit_demo/archonit_demo_app.dart';
import 'package:archonit_demo/data/db/db_client.dart';
import 'package:archonit_demo/data/db/hive_db_client_impl.dart';
import 'package:archonit_demo/data/db/hive_persistence_service.dart';
import 'package:archonit_demo/data/db/shared_db_client_impl.dart';
import 'package:archonit_demo/data/mappers/currency_mapper.dart';
import 'package:archonit_demo/data/network/api_client.dart';
import 'package:archonit_demo/data/network/api_client_dio_impl.dart';
import 'package:archonit_demo/data/network/api_client_http_impl.dart';
import 'package:archonit_demo/data/network/endpoints.dart';
import 'package:archonit_demo/data/network/params.dart';
import 'package:archonit_demo/data/repos/local_repo.dart';
import 'package:archonit_demo/data/repos/network_repo.dart';
import 'package:archonit_demo/domain/use_cases/currency_use_case.dart';
import 'package:archonit_demo/domain/use_cases/favorites_use_case.dart';
import 'package:archonit_demo/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:archonit_demo/presentation/home/bloc/home_cubit.dart';
import 'package:archonit_demo/resources/app_constants.dart';
import 'package:archonit_demo/resources/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // final ApiClient apiClient = ApiClientDioImpl(dio);
  final ApiClient apiClient = ApiClientHttpImpl(params);

  // DB
  // final pref = await SharedPreferences.getInstance();
  // final DbClient dbClient = SharedDbClientImpl(pref);

  await HivePersistenceService.instance.init();
  final DbClient dbClient = HiveDbClientImpl();

  // MAPPERS
  final CurrencyMapper currencyMapper = CurrencyMapper();

  // REPOS
  final NetworkRepo networkRepo = NetworkRepo(apiClient, currencyMapper, params);
  final LocalRepo localRepo = LocalRepo(dbClient, currencyMapper);

  // USE CASES
  final CurrencyUseCase currencyUseCase = CurrencyUseCase(networkRepo);
  final FavoritesUseCase favoritesUseCase = FavoritesUseCase(localRepo);

  // BLOCS
  final HomeCubit homeCubit = HomeCubit(currencyUseCase);
  final FavoritesCubit favoritesCubit = FavoritesCubit(favoritesUseCase);

  runApp(
    MultiBlocProvider(
      providers: [
        RepositoryProvider<CurrencyUseCase>(create: (c)=> currencyUseCase),
        BlocProvider<FavoritesCubit>(create: (c) => favoritesCubit),
      ],
      child: const ArchonitDemoApp(),
    ),
  );
}
