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

      final double result =
          alternative.value.criterias.fold(0.0, (tempCrit, crit) {
        final critValue = crit.value ?? 0;
        final subValue = crit.subCriterias.fold(0.0, (tempSub, sub) {
          final value = sub.value ?? 0;
          final optValue = sub.option?.value ?? 0;

          return tempSub += (value * optValue);
        });

        return tempCrit += (critValue * subValue);
      });

      LogHelper.instance.debug(message: "Result: $result");

      final log = alternative.value.criterias.map((crit) {
        return {
          crit.title: crit.value,
          "subs": crit.subCriterias.map((sub) {
            return {
              sub.title: sub.value,
              sub.option?.title: sub.option?.value,
            };
          }).toList(),
        };
      });

      LogHelper.instance.debug(message: "Priorities: $log");

      Get.back(
        result: alternative.value.copyWith(
          id: const Uuid().v4(),
          name: formData['name'],
          email: formData['email'],
          contact: formData['contact'],
          dateTime: DateTime.now(),
          result: result,
        ),
      );
    }
  }

  void save() {
    if (formKey.currentState!.saveAndValidate()) {
      final formData = formKey.currentState!.value;

      final double result =
          alternative.value.criterias.fold(0.0, (tempCrit, crit) {
        final critValue = crit.value ?? 0;
        final subValue = crit.subCriterias.fold(0.0, (tempSub, sub) {
          final value = sub.value ?? 0;
          final optValue = sub.option?.value ?? 0;

          return tempSub += (value * optValue);
        });

        return tempCrit += (critValue * subValue);
      });

      LogHelper.instance.debug(message: "Result: $result");

      final log = alternative.value.criterias.map((crit) {
        return {
          crit.title: crit.value,
          "subs": crit.subCriterias.map((sub) {
            return {
              sub.title: sub.value,
              sub.option?.title: sub.option?.value,
            };
          }).toList(),
        };
      });

      LogHelper.instance.debug(message: "Priorities: $log");

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
    criterias = modelRepository.getModel().criterias;

    isEdit = Get.parameters['id'] != null;

    if (Get.arguments == null) {
      alternative.value = alternative.value.copyWith(
        criterias: criterias.map((e) => e.toForm()).toList(),
      );
    }

    update();
  }
}
