import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class AppModule {
  static Future<void> inject() async {
    Get.lazyPut<GetStorage>(() => GetStorage());
  }
}
