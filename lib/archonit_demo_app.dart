import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/auto_router.dart';

class ArchonitDemoApp extends StatelessWidget {
  const ArchonitDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter().config(),
    );
  }
}
