import 'package:archonit_demo/domain/use_cases/currency_use_case.dart';
import 'package:archonit_demo/presentation/home/bloc/home_cubit.dart';
import 'package:archonit_demo/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => HomeCubit(RepositoryProvider.of<CurrencyUseCase>(c))..getCurrencies(),
      child: const HomeScreen(),
    );
  }
}
