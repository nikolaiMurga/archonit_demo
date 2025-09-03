import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'api_client.dart';
import 'params.dart';

class ApiClientHttpImpl implements ApiClient {
  final Params _params;

  ApiClientHttpImpl(this._params);

  // GET
  @override
  Future<http.Response> get({required String endpoint}) async {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: _params.getHeaders(token: dotenv.env['API_TOKEN']),
    );
    return response;
  }
}
