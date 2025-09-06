class CurrencyModel {
  final String symbol;
  final double priceUsd;

  CurrencyModel({
    required this.symbol,
    required this.priceUsd,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        symbol: json['symbol'] ?? 'symbol',
        priceUsd: double.tryParse(json['priceUsd']) ?? 0.00,
      );
}
