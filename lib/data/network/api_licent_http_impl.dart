import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../resources/app_strings.dart';
import 'api_client.dart';
import 'params.dart';

class ApiClientHttpImpl implements ApiClient {
  final Params _params;

  ApiClientHttpImpl(this._params);

  // GET
  @override
  Future<http.Response> get({required String url}) async {
    final response = await http.get(
      Uri.parse(url),
      headers: _params.getHeaders(token: dotenv.env[AppStrings.apiToken])
    );
    return response;
  }
}
