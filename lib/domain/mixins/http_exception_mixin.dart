import 'dart:convert';

import 'package:archonit_demo/app/logging_service.dart';
import 'package:archonit_demo/domain/models/error_model.dart';
import 'package:http/http.dart';

mixin HttpExceptionMixin {
  Future<Response> handleResponseStatus({required Future<dynamic> apiCall}) async {
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

    return response;
  }
}
