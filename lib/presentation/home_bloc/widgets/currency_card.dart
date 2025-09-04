import 'package:archonit_demo/domain/ui_models/currencies_ui_card_model.dart';
import 'package:archonit_demo/resources/app_test_styles.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final CurrencyUiCardModel cardModel;

  const CurrencyCard({super.key, required this.cardModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(color: cardModel.color, borderRadius: BorderRadius.circular(18)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(cardModel.currencyModel.symbol, style: AppTextStyles.text16w600),
            ),
            const Expanded(child: SizedBox()),
            Text('\$${cardModel.currencyModel.priceUsd.toStringAsFixed(2)}', style: AppTextStyles.text16w600),
          ],
        ),
      ),
    );
  }
}
