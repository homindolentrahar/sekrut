import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/data/repository/selection_repository.dart';
import 'package:sekrut/features/domain/models/ahp_model.dart';
import 'package:sekrut/features/domain/models/alternatif.dart';
import 'package:sekrut/features/domain/models/selection.dart';
import 'package:sekrut/util/helpers/log_helper.dart';
import 'package:uuid/uuid.dart';

class CrudSelectionController extends GetxController {
  final SelectionRepository selectionRepository;
  final ModelRepository modelRepository;

  CrudSelectionController({
    required this.selectionRepository,
    required this.modelRepository,
  });

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  late AHPModel model;
  List<Alternatif> alternatives = [];

  @override
  void onInit() {
    super.onInit();

    getModel();
  }

  Future<void> create() async {
    if (formKey.currentState!.saveAndValidate()) {
      final value = formKey.currentState!.value;

      LogHelper.instance.debug(message: "Form value: $value");

      final selection = Selection(
        id: const Uuid().v4(),
        name: value['name'],
        description: value['description'],
        selectedAlternatives: value['alt_count'],
        model: model,
        dateTime: DateTime.now(),
        alternatives: (value['alternatives'] as List<dynamic>)
            .map((e) => Alternatif.fromJson(e))
            .toList(),
      );

      selectionRepository.createSelection(selection);

      Get.back();
    }
  }

  void addAlternative(Alternatif data) {
    alternatives.add(data);

    update();
  }

  void updateAlternative(Alternatif data) {
    final foundIndex = alternatives.indexWhere(
      (element) => element.id == data.id,
    );
    alternatives[foundIndex] = data;

    update();
  }

  void removeAlternative(Alternatif data) {
    alternatives.removeWhere((element) => element.id == data.id);

    update();
  }

  void getModel() {
    model = modelRepository.getModel();

    update();
  }
}
