import 'package:archonit_demo/app/auto_router.dart';
import 'package:archonit_demo/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArchonitDemoApp extends StatelessWidget {
  const ArchonitDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp.router(debugShowCheckedModeBanner: false, routerConfig: AppRouter().config());
  }
}
