class CurrenciesRequest {
  final int limit;
  final int page;

  CurrenciesRequest({this.limit = 15, required this.page});

  int get getOffset => limit * page;
}
