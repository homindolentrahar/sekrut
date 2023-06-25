import 'dart:convert';

import 'package:flutter/services.dart';

abstract class JsonHelper {
  static Future<dynamic> readJson(String file) async {
    final response = await rootBundle.loadString('assets/jsons/$file.json');
    final data = await json.decode(response);

    return data;
  }
}
