import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/criterias_repository.dart';
import 'package:sekrut/features/data/repository/intensity_repository.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/domain/models/ahp_model.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/features/domain/models/intensity.dart';
import 'package:sekrut/features/domain/models/sub_criteria.dart';
import 'package:sekrut/route/app_route.dart';
import 'package:sekrut/util/helpers/ahp_calculation.dart';
import 'package:uuid/uuid.dart';

List<Criteria> _calculate(List<Criteria> list) {
  final List<Criteria> temp = [];
  final critCalc = AHPCalculation(list: list);

  for (var critIndex = 0; critIndex < list.length; critIndex++) {
    final criteria = list[critIndex];
    final subCalc = AHPCalculation(list: criteria.subCriterias);
    final List<SubCriteria> subs = [];

    for (var subIndex = 0;
        subIndex < criteria.subCriterias.length;
        subIndex++) {
      final List<SubCriteriaOption> options = [];
      final subCriteria = criteria.subCriterias[subIndex];
      final optCalc = AHPCalculation(list: subCriteria.options);

      for (var optIndex = 0;
          optIndex < subCriteria.options.length;
          optIndex++) {
        final opt = subCriteria.options[optIndex].copyWith(
          value: optCalc.getPriority(subCriteria.options[optIndex]),
        );

        options.add(opt);
      }

      subs.add(
        subCriteria.copyWith(
          value: subCalc.getPriority(subCriteria),
          options: options,
        ),
      );
    }

    temp.add(
      criteria.copyWith(
        value: critCalc.getPriority(list[critIndex]),
        subCriterias: subs,
      ),
    );
  }

  return temp;
}

Future<List<Criteria>> calculatePriorities(List<Criteria> list) {
  return compute(
    _calculate,
    list,
  );
}

class CrudModelController extends GetxController {
  final CriteriasRepository criteriasRepository;
  final ModelRepository modelRepository;
  final IntensityRepository intensityRepository;

  CrudModelController({
    required this.criteriasRepository,
    required this.modelRepository,
    required this.intensityRepository,
  });

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final AHPModel data = Get.arguments?['data'] ?? AHPModel.empty();
  late List<Criteria> criterias;

  List<IntensityForm> intensities = [];
  List<Intensity> intensitiesData = [];
  Map<String, List<IntensityValue>> mappedIntensities = {};

  bool get isEdit => Get.parameters['id'] != null;

  @override
  void onInit() {
    super.onInit();

    loadAllData();
  }

  Future<void> loadAllData() async {
    criterias = List.from(data.criterias);
    intensities = intensityRepository.getSavedIntensity();
    intensitiesData = await intensityRepository.getIntensity();
    mappedIntensities = intensities
        .asMap()
        .map((key, value) => MapEntry(value.slug, value.values));
    if (criterias.isEmpty) {
      criterias = await criteriasRepository.getCriterias();
    }

    update();
  }

  Future<void> saveModel() async {
    if (formKey.currentState!.saveAndValidate()) {
      final value = formKey.currentState!.value;
      final priorities = await calculatePriorities(criterias);

      final ahpModel = data.copyWith(
        id: const Uuid().v4(),
        title: value['name'],
        description: value['desc'],
        dateTime: DateTime.now(),
        criterias: priorities,
      );

      modelRepository.saveModel(ahpModel);

      Get.offAllNamed(Routes.selection);
    }
  }

  Future<void> updateModel() async {
    if (formKey.currentState!.saveAndValidate()) {
      final value = formKey.currentState!.value;
      final priorities = await calculatePriorities(criterias);

      final ahpModel = data.copyWith(
        title: value['name'],
        description: value['desc'],
        dateTime: DateTime.now(),
        criterias: priorities,
      );

      modelRepository.saveModel(ahpModel);

      Get.back();
    }
  }

  Future<void> saveIntensities(List<IntensityForm> values) async {
    await intensityRepository.saveIntensity(values);
  }

  void onCriteriaReordered(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex--;
    }

    final movedItem = criterias.removeAt(oldIndex);
    criterias.insert(newIndex, movedItem);

    update();
  }

  void onSubCriteriaReordered(int oldIndex, int newIndex, Criteria criteria) {
    if (newIndex > oldIndex) {
      newIndex--;
    }

    final List<SubCriteria> subs = List.from(criteria.subCriterias);

    final movedItem = subs.removeAt(oldIndex);
    subs.insert(newIndex, movedItem);

    criterias[criterias.indexOf(criteria)] = criterias
        .firstWhere((element) => element.slug == criteria.slug)
        .copyWith(subCriterias: subs);

    update();
  }
}
