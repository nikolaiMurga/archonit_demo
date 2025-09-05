import 'package:archonit_demo/domain/mixins/http_exception_mixin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../../resources/app_strings.dart';
import 'api_client.dart';
import 'params.dart';

class ApiClientHttpImpl with HttpExceptionMixin implements ApiClient {
  final Params _params;

  ApiClientHttpImpl(this._params);

  // GET
  @override
  Future<String> get({required String url}) async {
    final call = http.get(Uri.parse(url), headers: _params.getHeaders(token: dotenv.env[AppStrings.apiToken]));
    final body = await handleResponseStatus(apiCall: call);
    return body;
  }
}
