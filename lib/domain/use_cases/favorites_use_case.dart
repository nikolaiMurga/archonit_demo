import 'package:archonit_demo/data/repos/local_repo.dart';
import 'package:archonit_demo/domain/models/currency.dart';

class FavoritesUseCase {
  final LocalRepo _localRepo;

  FavoritesUseCase(this._localRepo);

  Future<bool> saveFavoritesCurrencies({required List<Currency> list}) async {
    return _localRepo.saveFavoriteCurrencies(list: list);
  }

  List<Currency> loadFavoriteCurrencies() {
    return _localRepo.loadFavoriteCurrencies();
  }

  Future<bool> removeFavoriteCurrencies() async {
    return _localRepo.removeFavoriteCurrencies();
  }
}
