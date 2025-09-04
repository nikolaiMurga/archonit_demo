import '../../data/network/dtos/currency_dto.dart';

class CurrencyModel {
  final String id;
  final String symbol;
  final String name;
  final double priceUsd;

  CurrencyModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.priceUsd,
  });

  factory CurrencyModel.fromDto(CurrencyDto dto) => CurrencyModel(
        id: dto.id ?? 'id',
        symbol: dto.symbol ?? 'symbol',
        name: dto.name ?? 'name',
        priceUsd: double.tryParse(dto.priceUsd!) ?? 0.00,
      );
}
