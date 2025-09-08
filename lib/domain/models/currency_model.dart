class CurrencyModel {
  final String symbol;
  final String priceUsd;

  CurrencyModel({
    required this.symbol,
    required this.priceUsd,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        symbol: json['symbol'] ?? 'symbol',
        priceUsd: json['priceUsd'] ?? '0.00',
      );

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'priceUsd': priceUsd,
      };
}
