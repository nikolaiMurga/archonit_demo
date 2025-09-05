part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeSucceed extends HomeState {
  final List<CurrencyUiCardModel> currencyUiModelList;
  final bool isLastPage;

  const HomeSucceed({required this.currencyUiModelList, required this.isLastPage});

  @override
  List<Object> get props => [currencyUiModelList, isLastPage];
}

final class HomeError extends HomeState {
  final String error;

  const HomeError({required this.error});

  @override
  List<Object> get props => [error];
}

final class HomeEmpty extends HomeState {
  @override
  List<Object> get props => [];
}

final class HomeScroll extends HomeState {
  @override
  List<Object> get props => [];
}
