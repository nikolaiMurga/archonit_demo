import 'package:archonit_demo/data/network/requests/currencies_request.dart';
import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/domain/models/error_model.dart';
import 'package:archonit_demo/domain/use_cases/currency_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CurrencyUseCase _currencyUseCase;

  HomeCubit(this._currencyUseCase) : super(HomeState());

  void initialFetch() {
    emit(HomeState(isLoading: true));
    fetchPaginatedCurrencies();
  }

  Future<void> fetchPaginatedCurrencies() async {
    if (state.isLastPage) return;
    try {
      final request = CurrenciesRequest(page: state.nextPage);
      final paginatedCurrencies = await _currencyUseCase.fetchCurrencies(request: request);
      if (paginatedCurrencies.currenciesList.isEmpty) {
        emit(HomeState());
      } else {
        final updatedList = [...state.currenciesList, ...paginatedCurrencies.currenciesList];
        emit(HomeState(
          currenciesList: updatedList,
          nextPage: state.nextPage + 1,
          isLastPage: state.nextPage == paginatedCurrencies.totalPages,
        ));
      }
    } on ErrorModel catch (e) {
      emit(HomeState(errorMessage: e.message));
    }
  }
}
