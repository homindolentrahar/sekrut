import 'package:get_storage/get_storage.dart';
import 'package:sekrut/core/constant/app_constants.dart';

abstract class AppConfig {
  static Future<void> init() async {
    await GetStorage.init(AppConstants.appStorage);
  }
}
