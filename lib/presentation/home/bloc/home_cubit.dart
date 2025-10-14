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

  void updateFavorites() => emit(HomeInfoState(message: 'message'));
}
