import 'dart:convert';

import 'package:sekrut/features/domain/models/intensity.dart';
import 'package:sekrut/util/helpers/box_helper.dart';
import 'package:sekrut/util/helpers/json_helper.dart';

class IntensityRepository {
  final BoxHelper intensityBox;

  IntensityRepository(this.intensityBox);

  Future<void> saveIntensity(List<IntensityForm> data) {
    return intensityBox.addAllValue(data.map((e) => e.toJson()).toList());
  }

  Future<List<Intensity>> getIntensity() async {
    final List<dynamic> response = await JsonHelper.readJson("intensity");

    return response.map((e) => Intensity.fromJson(e)).toList();
  }

  List<Intensity> getSavedIntensity() {
    final result = intensityBox.getValues();
    final decodedResult = json.decode(json.encode(result));

    return intensityBox
        .getValues()
        .map((item) => Intensity.fromJson(decodedResult))
        .toList();
  }
}
