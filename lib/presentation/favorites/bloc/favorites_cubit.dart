import 'package:archonit_demo/domain/models/currency.dart';
import 'package:archonit_demo/domain/models/error_model.dart';
import 'package:archonit_demo/domain/use_cases/favorites_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesUseCase _favoritesUseCase;

  FavoritesCubit(this._favoritesUseCase) : super(FavoritesState(favoritesList: [])) {
    loadFavoritesCurrenciesList();
  }

  void loadFavoritesCurrenciesList() {
    emit(FavoritesState(isLoading: true, favoritesList: state.favoritesList));
    final loadedList = _favoritesUseCase.loadFavoriteCurrencies();
    emit(FavoritesState(favoritesList: loadedList));
  }
}
