import '../../data/network/dto/currency_dto.dart';
import '../mixins/random_color_mixin.dart';
import '../models/currency.dart';

class CurrencyMapper with RandomColorMixin {
  Currency fromDto(CurrencyDto dto) {
    final color = generateRandomColor();
    return Currency(
      symbol: dto.symbol ?? 'symbol',
      priceUsd: double.parse(dto.priceUsd ?? '0.00'),
      color: color,
    );
  }
}
