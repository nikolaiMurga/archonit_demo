import '../../data/network/dto/currency_dto.dart';
import '../mixins/random_color_mixin.dart';
import '../models/currency_model.dart';

class CurrencyMapper with RandomColorMixin {
  CurrencyModel fromDto(CurrencyDto dto) {
    final color = generateRandomColor();
    return CurrencyModel(
      symbol: dto.symbol ?? 'symbol',
      priceUsd: double.parse(dto.priceUsd ?? '0.00'),
      color: color,
    );
  }
}
