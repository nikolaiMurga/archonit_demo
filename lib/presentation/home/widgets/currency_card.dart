import 'package:flutter/material.dart';

import '../../../domain/models/currency.dart';
import '../../../resources/app_test_styles.dart';

class CurrencyCard extends StatelessWidget {
  final Currency currency;

  const CurrencyCard({super.key, required this.currency});

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
    );
  }
}
