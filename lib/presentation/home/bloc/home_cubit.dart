import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/currency.dart';
import '../../../domain/models/error_model.dart';
import '../../../domain/use_cases/currency_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CurrencyUseCase _currencyUseCase;

  HomeCubit(this._currencyUseCase) : super(const HomeState());

  void initialFetch() {
    emit(const HomeState(isLoading: true));
    _currencyUseCase.resetPagination();
    fetchPaginatedCurrencies();
  }

  Future<void> fetchPaginatedCurrencies() async {
    if (_currencyUseCase.isLastPage) return;

    try {
      final updatedList = await _currencyUseCase.fetchCurrencies();

      emit(HomeState(
        currenciesList: updatedList,
        isLastPage: _currencyUseCase.isLastPage,
      ));
    } on ErrorModel catch (e) {
      emit(HomeState(
        currenciesList: state.currenciesList,
        errorMessage: e.message,
      ));
    }
  }
}
