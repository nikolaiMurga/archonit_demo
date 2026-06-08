import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/db/db_client.dart';
import '../data/db/shared_db_client_impl.dart';
import '../data/mappers/currency_mapper.dart';
import '../data/network/api_client.dart';
import '../data/network/api_client_dio_impl.dart';
import '../data/network/params.dart';
import '../data/repos/local_repo_impl.dart';
import '../data/repos/network_repo_impl.dart';
import '../domain/repos/local_repo.dart';
import '../domain/repos/network_repo.dart';
import '../domain/use_cases/currency_use_case.dart';
import '../domain/use_cases/favorites_use_case.dart';
import '../presentation/favorites/bloc/favorites_cubit.dart';
import '../presentation/home/bloc/home_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  getIt.registerFactory<Params>(() => Params());
  // api clients
  getIt.registerSingleton<ApiClient>(ApiClientDioImpl());
  // getIt.registerSingleton<ApiClient>(ApiClientHttpImpl(getIt.get<Params>()));

  // local storage
  getIt.registerSingletonAsync<SharedPreferences>(() async => await SharedPreferences.getInstance());
  await getIt.allReady();
  getIt.registerSingleton<DbClient>(SharedDbClientImpl(getIt<SharedPreferences>()));
  // getIt.registerSingleton<DbClient>(HiveDbClientImpl());

  // mappers
  getIt.registerFactory<CurrencyMapper>(() => CurrencyMapper());

  // repos
  getIt.registerFactory<NetworkRepo>(() => NetworkRepoImpl(getIt.get<ApiClient>(), getIt<CurrencyMapper>(), getIt<Params>()));
  getIt.registerFactory<LocalRepo>(() => LocalRepoImpl(getIt<DbClient>(), getIt<CurrencyMapper>()));

  // use cases
  getIt.registerFactory<CurrencyUseCase>(() => CurrencyUseCase(getIt<NetworkRepo>()));
  getIt.registerSingleton<FavoritesUseCase>(FavoritesUseCase(getIt<LocalRepo>()));

  // blocs
  getIt.registerSingleton<HomeCubit>(HomeCubit(getIt<CurrencyUseCase>()));
  getIt.registerSingleton<FavoritesCubit>(FavoritesCubit(getIt<FavoritesUseCase>()));
}
