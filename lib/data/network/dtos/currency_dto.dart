class CurrencyDto {
  String? id;
  String? symbol;
  String? name;
  double? priceUsd;

  CurrencyDto({
    this.id,
    this.symbol,
    this.name,
    this.priceUsd,
  });

  factory CurrencyDto.fromJson(Map<String, dynamic> json) => CurrencyDto(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        priceUsd: json['priceUsd'],
      );
}
