import 'package:flutter/foundation.dart';

class LogService {
  static LogService? _instance;

  LogService._privateConstructor();

  factory LogService() {
    _instance ??= LogService._privateConstructor();
    return _instance!;
  }

  static List<String> logs = [];

  static void printLog(String message) {
    if (kDebugMode) {
      logs.add('${DateTime.now()} ----------> [LOG]: $message');
      debugPrint('${DateTime.now()} -----------> [LOG]:  $message');
    }
  }
}
