import 'dart:async';

import '../models/currency.dart';
import '../repos/local_repo.dart';

class FavoritesUseCase {
  final LocalRepo _localRepo;

  final StreamController<List<Currency>> _controller = StreamController<List<Currency>>.broadcast();
  List<Currency> _cachedFavorites = [];

  FavoritesUseCase(this._localRepo) {
    _cachedFavorites = _localRepo.loadFavoriteCurrencies();
  }

  Stream<List<Currency>> get favoritesStream => _controller.stream;

  List<Currency> get currentFavorites => List<Currency>.from(_cachedFavorites);

  bool isFavorite(Currency currency) => _cachedFavorites.any((curr) => curr.id == currency.id);

  Stream<bool> isFavoriteStream(Currency currency) {
    return _controller.stream.map((list) => list.any((curr) => curr.id == currency.id));
  }

  Future<void> toggleFavorite(Currency currency) async {
    final isExist = _cachedFavorites.any((curr) => curr.id == currency.id);

    final updatedList = isExist ? _cachedFavorites.where((curr) => curr.id != currency.id).toList() : [..._cachedFavorites, currency];

    final success = await _localRepo.saveFavoriteCurrencies(list: updatedList);

    if (success) {
      _cachedFavorites = updatedList;
      _controller.add([..._cachedFavorites]);
    }
  }

  Future<bool> removeFavoriteCurrencies() async {
    final success = await _localRepo.removeFavoriteCurrencies();
    if (success) {
      _cachedFavorites = [];
      _controller.add([]);
    }
    return success;
  }
}
