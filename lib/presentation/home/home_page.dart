import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/injection.dart';
import 'bloc/home_cubit.dart';
import 'home_screen.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeCubit>()..initialFetch(),
      child: const HomeScreen(),
    );
  }
}
