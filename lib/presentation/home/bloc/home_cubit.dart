import 'package:archonit_demo/data/network/requests/currencies_request.dart';
import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/domain/models/error_model.dart';
import 'package:archonit_demo/domain/use_cases/currency_use_case.dart';
import 'package:archonit_demo/domain/use_cases/favorites_use_case.dart';
import 'package:archonit_demo/resources/app_strings.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CurrencyUseCase _currencyUseCase;
  final FavoritesUseCase _favoritesUseCase;

  HomeCubit(this._currencyUseCase, this._favoritesUseCase) : super(HomeInitial());

  final List<Currency> _currenciesList = [];
  bool _isLastPage = false;
  int _nextPage = 0;

  void _clear() {
    _currenciesList.clear();
    _isLastPage = false;
    _nextPage = 0;
  }

  Future<void> getCurrencies({bool isReload = false, bool isScroll = false}) async {
    if (_isLastPage && !isReload) return;

    if (!isScroll) {
      emit(HomeLoading());
      _clear();
    } else {
      emit(HomeScroll());
    }
    _fetchPaginatedCurrencies();
  }

  Future<void> _fetchPaginatedCurrencies() async {
    try {
      final request = CurrenciesRequest(page: _nextPage);
      final paginatedCurrencies = await _currencyUseCase.fetchCurrencies(request: request);

      if (paginatedCurrencies.currenciesList.isEmpty) {
        emit(HomeEmpty());
      } else {
        _isLastPage = _nextPage == paginatedCurrencies.totalPages;
        if (!_isLastPage) _nextPage += 1;
        _currenciesList.addAll(paginatedCurrencies.currenciesList);
        emit(HomeSucceed(currenciesList: _currenciesList, isLastPage: _isLastPage));
      }
    } on ErrorModel catch (e) {
      emit(HomeError(error: e.message ?? AppStrings.noErrorMessage));
    }
  }

  Future<void> saveFavoriteCurrencies({required Currency model}) async {
    // load cached favorites list
    final favoritesList = _favoritesUseCase.loadFavoriteCurrencies();
    // check if model is in favorites
    final isModelInFavorites = favoritesList.contains(model);
    if (isModelInFavorites) {
      // if model is in favorites just inform user
      emit(HomeInfoState(message: '${model.symbol} is in favorites already'));
    } else {
      // if no, save model to favorites
      favoritesList.add(model);
      try {
        // cached favorites list
        await _favoritesUseCase.saveFavoritesCurrencies(list: favoritesList);
        // inform user that caching successful
        emit(HomeInfoState(message: '${model.symbol} successfully added to  favorites '));
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    }
  }
}
