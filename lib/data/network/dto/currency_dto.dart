class CurrencyDto {
  final String? symbol;
  final String? priceUsd;

  CurrencyDto({
    this.symbol,
    this.priceUsd,
  });

  factory CurrencyDto.fromJson(Map<String, dynamic> json) {
    return CurrencyDto(
        symbol: json['symbol'],
        priceUsd: json['priceUsd'],
      );
  }
}
