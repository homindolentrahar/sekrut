import 'package:hive_flutter/hive_flutter.dart';
import 'package:sekrut/core/constant/app_boxes.dart';

abstract class AppConfig {
  static Future<void> init() async {
    await Hive.initFlutter();

    // final collection = await BoxCollection.open(
    //   AppBoxes.sekrut,
    //   {
    //     AppBoxes.app,
    //     AppBoxes.model,
    //     AppBoxes.selections,
    //   },
    //   path: "./",
    // );

    await Hive.openBox(AppBoxes.app);
    await Hive.openBox(AppBoxes.model);
    await Hive.openBox(AppBoxes.selections);
  }
}
