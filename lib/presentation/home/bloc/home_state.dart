part of 'home_cubit.dart';

class HomeState extends Equatable {
  final isLoading;
  final int nextPage;
  final List<Currency> currenciesList;
  final bool isLastPage;
  final bool hasError;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.nextPage = 1,
    this.currenciesList = const [],
    this.isLastPage = false,
    this.hasError = false,
    this.errorMessage,
  });

  @override
  List<Object> get props => [isLoading, nextPage, currenciesList, isLastPage, hasError];
}
