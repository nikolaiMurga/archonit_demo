
import 'package:flutter/material.dart';

import '../../../core/injection.dart';
import '../../../domain/models/currency.dart';
import '../../../domain/use_cases/favorites_use_case.dart';
import '../../../resources/app_test_styles.dart';
import 'favorite_status_builder.dart';

class CurrencyCard extends StatelessWidget {
  final Currency currency;

  const CurrencyCard({super.key, required this.currency});

  void _showContextMenu(BuildContext context, Offset position, bool isFavorite) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, overlay.size.width - position.dx, overlay.size.height - position.dy),
      items: [
        PopupMenuItem(
          value: 'favorite',
          child: Row(
            children: [
              Icon(isFavorite ? Icons.favorite_border : Icons.favorite),
              const SizedBox(width: 8),
              Text(isFavorite ? 'remove from favorites' : 'add to favorites'),
            ],
          ),
        ),
      ],
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
    if (result == 'favorite') {
      await getIt<FavoritesUseCase>().toggleFavorite(currency);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteUseCase = getIt<FavoritesUseCase>();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPressStart: (details) {
        final currentStatus = favoriteUseCase.isFavorite(currency);
        _showContextMenu(context, details.globalPosition, currentStatus);
      },
      child: SizedBox(
        height: 84,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(color: currency.color, borderRadius: BorderRadius.circular(18)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(currency.symbol, style: AppTextStyles.text16w600),
              ),
              FavoriteStatusBuilder(
                currency: currency,
                builder: (isFavorite) {
                  return isFavorite
                      ? const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.favorite, size: 12))
                      : const SizedBox.shrink();
                },
              ),
              const Spacer(),
              Text('\$${currency.priceUsd.toStringAsFixed(2)}', style: AppTextStyles.text16w600),
            ],
          ),
        ),
      ),
    );
  }
}
