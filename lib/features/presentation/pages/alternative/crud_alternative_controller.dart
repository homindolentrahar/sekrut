import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/criterias_repository.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/domain/models/alternatif.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/util/helpers/log_helper.dart';
import 'package:uuid/uuid.dart';

class CrudAlternativeController extends GetxController {
  final CriteriasRepository criteriaRepository;
  final ModelRepository modelRepository;

  CrudAlternativeController(
      {required this.criteriaRepository, required this.modelRepository});

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  bool isEdit = false;
  List<Criteria> criterias = [];
  Rx<Alternatif> alternative = Rx(Get.arguments ?? Alternatif.empty());

  @override
  void onInit() {
    super.onInit();

    ever(alternative, (callback) {
      LogHelper.instance.debug(
        message: "$alternative",
      );
    });

    loadCriterias();
  }

  void add() {
    if (formKey.currentState!.saveAndValidate()) {
      final formData = formKey.currentState!.value;

      Get.back(
        result: alternative.value.copyWith(
          id: const Uuid().v4(),
          name: formData['name'],
          email: formData['email'],
          contact: formData['contact'],
          dateTime: DateTime.now(),
        ),
      );
    }
  }

  void save() {
    if (formKey.currentState!.saveAndValidate()) {
      final formData = formKey.currentState!.value;

      final double result = alternative.value.criterias.fold(
        0.0,
        (previousValue, element) => previousValue += element.subCriterias.fold(
          0.0,
          (previousValue, element) => previousValue += element.value ?? 0,
        ),
      );

      Get.back(
        result: alternative.value.copyWith(
          name: formData['name'],
          email: formData['email'],
          contact: formData['contact'],
          dateTime: DateTime.now(),
          result: result,
        ),
      );
    }
  }

  Future<void> loadCriterias() async {
    final List<Criteria> temp = [];

    final result = await criteriaRepository.getCriterias();

    modelRepository.getModel().criterias.map((e) => e.slug).toList().forEach(
          (slug) => temp.add(
            result.firstWhere((element) => element.slug == slug),
          ),
        );

    criterias = temp;

    isEdit = Get.parameters['id'] != null;

    if (Get.arguments == null) {
      alternative.value = alternative.value.copyWith(
        criterias: criterias.map((e) => e.toForm()).toList(),
      );
    }

    update();
  }
}
