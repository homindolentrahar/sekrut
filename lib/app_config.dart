import 'package:get_storage/get_storage.dart';

abstract class AppConfig {
  static Future<void> init() async {
    await GetStorage.init();
  }
}
