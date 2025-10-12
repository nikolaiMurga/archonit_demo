import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveBoxes {
  static const favoriteCurrenciesBox = 'favorite_currencies_box';
}

class HivePersistenceService {
  HivePersistenceService._internal();

  static final HivePersistenceService _instance = HivePersistenceService._internal();

  static HivePersistenceService get instance => _instance;

  bool _isInitialized = false;

  Box get favoriteCurrenciesBox => Hive.box(HiveBoxes.favoriteCurrenciesBox);

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);

      await Future.wait([
        Hive.openBox(HiveBoxes.favoriteCurrenciesBox),
      ]);

      _isInitialized = true;
    } catch (e) {
      debugPrint('Hive initialization failed: $e');
    }
  }

  Future<void> clearBoxes() async {
    if (!_isInitialized) {
      await init();
    }
    await Future.wait([
      Hive.box(HiveBoxes.favoriteCurrenciesBox).clear(),
    ]);
  }
}
