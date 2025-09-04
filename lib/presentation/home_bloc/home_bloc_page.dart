import 'package:archonit_demo/presentation/home_bloc/bloc/home_bloc_cubit.dart';
import 'package:archonit_demo/presentation/home_bloc/home_bloc_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBlocPage extends StatelessWidget {
  const HomeBlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeBlocCubit>(context)..getCurrencies(),
      child: const HomeBlocScreen(),
    );
  }
}
