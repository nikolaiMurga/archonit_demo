import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/currency_use_case.dart';
import 'bloc/home_cubit.dart';
import 'home_screen.dart';

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
