import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../domain/mixins/http_exception_mixin.dart';
import '../../resources/app_strings.dart';
import 'api_client.dart';
import 'endpoints.dart';
import 'params.dart';
import '../../../data/network/requests/currencies_request.dart';
import 'responses/currencies_response.dart';

class ApiClientHttpImpl with HttpExceptionMixin implements ApiClient {
  final Params _params;

  ApiClientHttpImpl(this._params);

  // GET
  Future<http.Response> _get({required String url}) async {
    return await handleResponseStatus(
      apiCall: http.get(Uri.parse(url), headers: _params.getHeaders(token: dotenv.env[AppStrings.apiToken])),
    );
  }

  Map<String, dynamic> _decoder(http.Response resp) {
    final body = utf8.decode(resp.bodyBytes);
    final data = jsonDecode(body);
    return data;
  }

  @override
  Future<CurrenciesResponse> fetchCurrenciesResponse({required CurrenciesRequest request}) async {
    final queryString = Uri(queryParameters: _params.getCurrenciesRequestQueryParams(request: request));
    final resp = await _get(url: '${Endpoints.baseUrl}${Endpoints.fetchAssets}$queryString');
    final data = _decoder(resp);
    return CurrenciesResponse.fromJson(data);
  }
}
