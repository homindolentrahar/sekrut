import 'package:hive_flutter/hive_flutter.dart';
import 'package:sekrut/core/constant/app_boxes.dart';

abstract class AppConfig {
  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(AppBoxes.app);
    await Hive.openBox(AppBoxes.model);
    await Hive.openBox(AppBoxes.selections);
    await Hive.openBox(AppBoxes.intensities);
  }
}
