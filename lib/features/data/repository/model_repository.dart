import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:sekrut/core/constant/app_boxes.dart';
import 'package:sekrut/features/domain/models/ahp_model.dart';
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
  }

  Stream<AHPModel> listenModel() {
    return modelBox
        .listenValue(AppBoxes.ahpModelKey)
        .map(
          (data) => AHPModel.fromJson(
            json.decode(json.encode(data)),
          ),
        )
        .startWith(
          AHPModel.fromJson(
            json.decode(json.encode(modelBox.getValue(AppBoxes.ahpModelKey))),
          ),
        );
  }
}
