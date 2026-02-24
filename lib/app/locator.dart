import 'package:archonit_demo/data/db/db_client.dart';
import 'package:archonit_demo/data/db/shared_db_client_impl.dart';
import 'package:archonit_demo/data/mappers/currency_mapper.dart';
import 'package:archonit_demo/data/network/api_client.dart';
import 'package:archonit_demo/data/network/api_client_dio_impl.dart';
import 'package:archonit_demo/data/network/params.dart';
import 'package:archonit_demo/data/repos/local_repo.dart';
import 'package:archonit_demo/data/repos/network_repo.dart';
import 'package:archonit_demo/domain/use_cases/currency_use_case.dart';
import 'package:archonit_demo/domain/use_cases/favorites_use_case.dart';
import 'package:archonit_demo/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:archonit_demo/presentation/home/bloc/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class Locator {
  Future<void> setup() async {
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
    getIt.registerFactory<NetworkRepo>(() => NetworkRepo(getIt.get<ApiClient>(), getIt<CurrencyMapper>(), getIt<Params>()));
    getIt.registerFactory(() => LocalRepo(getIt<DbClient>(), getIt<CurrencyMapper>()));

    // use cases
    getIt.registerFactory<CurrencyUseCase>(() => CurrencyUseCase(getIt<NetworkRepo>()));
    getIt.registerFactory<FavoritesUseCase>(() => FavoritesUseCase(getIt<LocalRepo>()));

    // blocs
    getIt.registerSingleton<HomeCubit>(HomeCubit(getIt<CurrencyUseCase>()));
    getIt.registerSingleton<FavoritesCubit>(FavoritesCubit(getIt<FavoritesUseCase>()));
  }
}
