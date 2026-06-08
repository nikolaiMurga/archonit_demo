import 'package:flutter/material.dart';

import '../../../core/injection.dart';
import '../../../domain/models/currency.dart';
import '../../../domain/use_cases/favorites_use_case.dart';

class FavoriteStatusBuilder extends StatelessWidget {
  final Currency currency;
  final Widget Function(bool isFavorite) builder;

  const FavoriteStatusBuilder({
    super.key,
    required this.currency,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesUseCase = getIt<FavoritesUseCase>();

    return StreamBuilder<bool>(
      stream: favoritesUseCase.isFavoriteStream(currency),
      initialData: favoritesUseCase.isFavorite(currency),
      builder: (context, snapshot) {
        final isFavorite = snapshot.data ?? false;
        return builder(isFavorite);
      },
    );
  }
}
