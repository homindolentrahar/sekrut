import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BoxHelper {
  late Box _box;
  final String name;

  BoxHelper({required this.name}) {
    _box = Get.find<Box>(tag: name);
  }

  List<dynamic> getValues() {
    return _box.values.toList();
  }

  dynamic getValue(String key) {
    return _box.get(key);
  }

  Future<void> setValue(String key, dynamic value) {
    return _box.put(key, value);
  }

  Future<void> addValue(dynamic value) {
    return _box.add(value);
  }

  Future<void> addAllValue(List<dynamic> values) {
    return _box.addAll(values);
  }

  Stream<dynamic> listenValue(String key) {
    return _box.watch().map((event) => _box.get(key));
  }

  Stream<List<dynamic>> listenValues() async* {
    yield* _box.watch().map((event) => _box.values.toList());
  }
}
