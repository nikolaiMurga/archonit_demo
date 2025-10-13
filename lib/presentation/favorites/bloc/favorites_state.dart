part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  final bool isLoading;
  final List<Currency> favoritesList;
  final ErrorModel? error;

  const FavoritesState({this.isLoading = false, required this.favoritesList, this.error});

  @override
  List<Object?> get props => [isLoading, favoritesList, error];
}
