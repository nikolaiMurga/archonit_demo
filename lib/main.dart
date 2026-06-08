import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'archonit_demo_app.dart';
import 'core/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupDI();
  // for using hive as local storage uncomment this line
  // HivePersistenceService.instance.init();

  runApp(const ArchonitDemoApp());
}
