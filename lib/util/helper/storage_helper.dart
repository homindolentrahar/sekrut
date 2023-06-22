import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/constant/app_constants.dart';

class StorageHelper {
  late GetStorage _storage;

  static StorageHelper instance = StorageHelper._();

  StorageHelper._() {
    _storage = Get.find<GetStorage>(tag: AppConstants.appStorage);
    log("Values: ${_storage.getValues()}");
  }

  Future<void> write(String key, dynamic data) {
    return _storage.write(key, data);
  }

  Future<void> remove(String key) {
    return _storage.remove(key);
  }

  T? read<T>(String key) {
    return _storage.read(key);
  }
}
