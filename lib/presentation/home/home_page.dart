import 'package:archonit_demo/app/locator.dart';
import 'package:archonit_demo/domain/use_cases/currency_use_case.dart';
import 'package:archonit_demo/domain/use_cases/favorites_use_case.dart';
import 'package:archonit_demo/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:archonit_demo/presentation/home/bloc/home_cubit.dart';
import 'package:archonit_demo/presentation/home/home_screen.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      // create: (c) => HomeCubit(RepositoryProvider.of<CurrencyUseCase>(context))..getCurrencies(),
      create: (c) => getIt<HomeCubit>()..getCurrencies(),
      child: const HomeScreen(),
    );
  }
}
