import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/selection/data/repository/criterias_repository.dart';
import 'package:sekrut/features/selection/domain/models/criteria.dart';

class CrudAlternativeController extends GetxController {
  final CriteriasRepository repository;

  CrudAlternativeController(this.repository);

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  List<Criteria> criterias = [];

  @override
  void onInit() {
    super.onInit();

    loadCriterias();
  }

  Future<void> loadCriterias() async {
    final result = await repository.getCriterias();
    criterias = result;

    update();
  }
}
