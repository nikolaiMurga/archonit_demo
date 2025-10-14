class CurrencyDto {
  final String? id;
  final String? symbol;
  final String? priceUsd;

  CurrencyDto({this.id, this.symbol, this.priceUsd});

  factory CurrencyDto.fromJson(Map<String, dynamic> json) {
    return CurrencyDto(id: json['id'], symbol: json['symbol'], priceUsd: json['priceUsd']);
  }
}
