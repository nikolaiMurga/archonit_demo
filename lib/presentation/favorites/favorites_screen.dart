import 'package:archonit_demo/presentation/common/widgets/currency_card.dart';
import 'package:archonit_demo/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:archonit_demo/presentation/common/widgets/empty_state_widget.dart';
import 'package:archonit_demo/resources/app_strings.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/locator.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // value: BlocProvider.of<FavoritesCubit>(context),
      value: getIt<FavoritesCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(AppStrings.favorites)),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (c, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.favoritesList.isEmpty) {
              return Center(child: EmptyStateWidget());
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
