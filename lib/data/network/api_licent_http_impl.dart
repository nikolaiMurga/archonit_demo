import 'package:archonit_demo/domain/mixins/http_exception_mixin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../resources/app_strings.dart';
import 'api_client.dart';
import 'params.dart';

class ApiClientHttpImpl with HttpExceptionMixin implements ApiClient {
  final Params _params;

  ApiClientHttpImpl(this._params);

  // GET
  @override
  Future<Response> get({required String url}) async {
    final call = http.get(Uri.parse(url), headers: _params.getHeaders(token: dotenv.env[AppStrings.apiToken]));
    return await handleResponseStatus(apiCall: call);
  }
}
