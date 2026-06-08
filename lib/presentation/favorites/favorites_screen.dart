import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/injection.dart';
import '../../resources/app_strings.dart';
import '../common/widgets/currency_card.dart';
import '../common/widgets/empty_state_widget.dart';
import 'bloc/favorites_cubit.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<FavoritesCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text(AppStrings.favorites)),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (c, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.favoritesList.isEmpty) {
              return const Center(child: EmptyStateWidget());
            }
            return ListView.builder(
              itemCount: state.favoritesList.length,
              itemBuilder: (c, index) {
                return CurrencyCard(currency: state.favoritesList[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
