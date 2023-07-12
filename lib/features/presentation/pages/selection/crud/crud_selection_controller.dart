import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/intensity_repository.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/data/repository/selection_repository.dart';
import 'package:sekrut/features/domain/models/ahp_model.dart';
import 'package:sekrut/features/domain/models/alternatif.dart';
import 'package:sekrut/features/domain/models/intensity.dart';
import 'package:sekrut/features/domain/models/selection.dart';
import 'package:sekrut/util/helpers/log_helper.dart';
import 'package:uuid/uuid.dart';

class CrudSelectionController extends GetxController {
  final SelectionRepository selectionRepository;
  final ModelRepository modelRepository;
  final IntensityRepository intensityRepository;

  CrudSelectionController({
    required this.selectionRepository,
    required this.modelRepository,
    required this.intensityRepository,
  });

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  late AHPModel model;

  Selection data = Get.arguments?['data'] ?? Selection.empty();
  Map<String, List<IntensityValue>> intensities = {};

  bool get isEdit => data.id.isNotEmpty;

  @override
  void onInit() {
    super.onInit();

    getModel();

    LogHelper.instance.debug(message: "Count: ${data.selectedAlternatives}");
  }

  List<Alternatif> get sortedAlternatives {
    List<Alternatif> temp = [];

    temp = List.from((data.alternatives));

    return temp..sort((a, b) => (b.result ?? 0).compareTo(a.result ?? 0));
  }

  Future<void> createSelection() async {
    if (formKey.currentState!.saveAndValidate()) {
      final value = formKey.currentState!.value;

      final selection = data.copyWith(
        id: const Uuid().v4(),
        name: value['name'],
        description: value['description'],
        selectedAlternatives: value['alt_count'],
        model: model,
        dateTime: DateTime.now(),
        alternatives: sortedAlternatives,
      );

      selectionRepository.createSelection(selection);

      Get.back();
    }
  }

  Future<void> updateSelection() async {
    if (formKey.currentState!.saveAndValidate()) {
      final value = formKey.currentState!.value;

      final selection = data.copyWith(
        name: value['name'],
        description: value['description'],
        selectedAlternatives: value['alt_count'],
        dateTime: DateTime.now(),
        alternatives: sortedAlternatives,
      );

      LogHelper.instance.debug(
        message: "Alts: ${selection.alternatives.map((e) => e.name)}",
      );

      selectionRepository.updateSelection(selection.id, selection);

      Get.back();
      Get.back();
    }
  }

  void addAlternative(Alternatif value) {
    final List<Alternatif> tempAlts = List.from(data.alternatives);

    tempAlts.add(value);

    data = data.copyWith(
      alternatives: tempAlts,
    );

    update();
  }

  void updateAlternative(Alternatif value) {
    final List<Alternatif> tempAlts = List.from(data.alternatives);

    final foundIndex = tempAlts.indexWhere(
      (element) => element.id == value.id,
    );

    tempAlts[foundIndex] = value;

    data = data.copyWith(
      alternatives: tempAlts,
    );

    update();
  }

  void removeAlternative(Alternatif value) {
    final List<Alternatif> tempAlts = List.from(data.alternatives);

    tempAlts.removeWhere((element) => element.id == value.id);

    data = data.copyWith(
      alternatives: tempAlts,
    );

    update();
  }

  void getModel() {
    model = modelRepository.getModel();
    intensities = intensityRepository.getSavedIntensity().asMap().map(
          (key, value) => MapEntry(value.slug, value.values),
        );

    update();
  }
}
