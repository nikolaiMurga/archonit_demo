class AssetsRequest {
  final int limit;
  final int page;

  AssetsRequest({this.limit = 15, required this.page});

  int get getOffset => limit * page;
}
