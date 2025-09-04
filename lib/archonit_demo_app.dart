import 'package:archonit_demo/presentation/home_bloc/home_bloc_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArchonitDemoApp extends StatelessWidget {
  const ArchonitDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeBlocPage(),
    );
  }
}
