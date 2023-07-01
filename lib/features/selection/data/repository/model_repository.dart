import 'dart:convert';

import 'package:sekrut/core/constant/app_boxes.dart';
import 'package:sekrut/features/selection/domain/models/ahp_model.dart';
import 'package:sekrut/util/helpers/box_helper.dart';

class ModelRepository {
  final BoxHelper modelBox;

  ModelRepository(this.modelBox);

  Future<void> saveModel(AHPModel model) async {
    await modelBox.setValue(
      AppBoxes.ahpModelKey,
      model.toJson(),
    );
  }

  AHPModel getModel() {
    final result = modelBox.getValue(AppBoxes.ahpModelKey);
    final decodedResult = json.decode(json.encode(result));

    return result != null ? AHPModel.fromJson(decodedResult) : AHPModel.empty();
    // return AHPModel.empty();
  }
}
