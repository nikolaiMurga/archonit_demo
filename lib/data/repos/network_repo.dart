import 'dart:convert';

import '../../app/logging_service.dart';
import '../../domain/models/error_model.dart';
import '../network/api_client.dart';
import '../network/endpoints.dart';
import '../network/responses /assets_response.dart';

class NetworkRepo {
  final ApiClient _apiClient;

  NetworkRepo(this._apiClient);

  Future<String> _handleResponseStatus({required Future<dynamic> apiCall}) async {
    final stopwatch = Stopwatch()..start();
    final response = await apiCall;
    stopwatch.stop();
    final elapsedTime = stopwatch.elapsedMilliseconds;

    LogService.addLog('+/SERVER RESPONSE DELAY: $elapsedTime MILLISECONDS /+');
    LogService.addLog('${response.statusCode} => ${response.reasonPhrase}');

    String body = utf8.decode(response.bodyBytes);
    switch (response.statusCode) {
      case (200):
        break;
      case (>= 400 && < 500 && != 422 && != 401):
        throw ErrorModel.fromJson(jsonDecode(body));
      case (401):
        throw ErrorModel.fromJson(jsonDecode(body));
      case (422):
      // throw ErrorDto(detail: ValidationErrorDto.fromJson(jsonDecode(body)).detail!.first.msg);
      case (>= 500 && < 600):
      // throw ErrorDto(detail: response.reasonPhrase);
    }

    return body;
  }

  Future<AssetsResponse> fetchCurrenciesResponse() async {
    final body = await _handleResponseStatus(apiCall: _apiClient.get(url: '${Endpoints.baseUrl}${Endpoints.fetchAssets}'));
    return AssetsResponse.fromJson(jsonDecode(body));
  }
}
