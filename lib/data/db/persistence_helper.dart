import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveBoxes {
  static const favoriteCurrenciesBox = 'favorite_currencies_box';
}

class HiveTypeIds {
  static const workingStatus = 0;
}

class PersistenceHelper {
  static Future<void> initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    //register adapters
    // Hive.registerAdapter(FavoriteCurrencyEntityListAdapter());

    //open boxes
    await Future.wait([
      Hive.openBox(HiveBoxes.favoriteCurrenciesBox),
    ]);

    // await PersistenceHelper.clearBoxes();
  }

  static Future<void> clearBoxes() async {
    //clear boxes per app launch
    await Future.wait([
      Hive.box(HiveBoxes.favoriteCurrenciesBox).clear(),
    ]);
  }
}
