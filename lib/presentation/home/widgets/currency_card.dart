import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/presentation/home/bloc/home_cubit.dart';
import 'package:archonit_demo/resources/app_test_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyCard extends StatelessWidget {
  final Currency currency;

  const CurrencyCard({super.key, required this.currency});

  void _showContextMenu(BuildContext context, Offset position, Currency model) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, overlay.size.width - position.dx, overlay.size.height - position.dy),
      items: [
        PopupMenuItem(
          value: 'favorite',
          child: Row(
            children: [
              Icon(Icons.favorite_border),
              SizedBox(width: 8),
              Text('add to favorites'),
            ],
          ),
        ),
      ],
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    if (result == 'favorite') {
      await context.read<HomeCubit>().saveFavoriteCurrencies(model: currency);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPressStart: (details) => _showContextMenu(context, details.globalPosition, currency),
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
              const Expanded(child: SizedBox()),
              Text('\$${currency.priceUsd.toStringAsFixed(2)}', style: AppTextStyles.text16w600),
            ],
          ),
        ),
      ),
    );
  }
}
