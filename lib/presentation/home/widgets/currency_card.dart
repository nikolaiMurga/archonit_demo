import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/presentation/favorites/bloc/favorites_cubit.dart';
import 'package:archonit_demo/resources/app_test_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyCard extends StatefulWidget {
  final Currency currency;

  const CurrencyCard({super.key, required this.currency});

  @override
  State<CurrencyCard> createState() => _CurrencyCardState();
}



class _CurrencyCardState extends State<CurrencyCard> {
  void _showContextMenu(BuildContext context, Offset position, Currency model) async {
    final _isFavorite = context.read<FavoritesCubit>().state.favoritesList.contains(widget.currency);
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, overlay.size.width - position.dx, overlay.size.height - position.dy),
      items: [
        PopupMenuItem(
          value: 'favorite',
          child: Row(
            children: [
              Icon(_isFavorite ? Icons.favorite_border : Icons.favorite),
              SizedBox(width: 8),
              Text(_isFavorite ? 'remove from favorites' : 'add to favorites'),
            ],
          ),
        ),
      ],
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    if (result == 'favorite') {
      await context.read<FavoritesCubit>().updateFavoriteCurrencies(model: widget.currency);
      // temp solution to rebuild card on home screen
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final _isFavorite = context.watch<FavoritesCubit>().isFavorite(widget.currency);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPressStart: (details) => _showContextMenu(context, details.globalPosition, widget.currency),
      child: SizedBox(
        height: 84,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(color: widget.currency.color, borderRadius: BorderRadius.circular(18)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(widget.currency.symbol, style: AppTextStyles.text16w600),
              ),
              if (_isFavorite) Padding(padding: const EdgeInsets.all(8.0), child: Icon(Icons.favorite, size: 12)),
              const Expanded(child: SizedBox()),
              Text('\$${widget.currency.priceUsd.toStringAsFixed(2)}', style: AppTextStyles.text16w600),
            ],
          ),
        ),
      ),
    );
  }
}
