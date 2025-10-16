import 'package:archonit_demo/app/locator.dart';
import 'package:archonit_demo/archonit_demo_app.dart';
import 'package:archonit_demo/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Locator().setup();
  // for using hive as local storage uncomment this line
  // HivePersistenceService.instance.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FavoritesCubit>(create: (c) => getIt<FavoritesCubit>()),
      ],
      child: const ArchonitDemoApp(),
    ),
  );
}
