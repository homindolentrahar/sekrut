import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/criterias_repository.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/domain/models/ahp_model.dart';
import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/features/domain/models/sub_criteria.dart';
import 'package:sekrut/route/app_route.dart';
import 'package:sekrut/util/helpers/log_helper.dart';
import 'package:uuid/uuid.dart';

class CrudModelController extends GetxController {
  final CriteriasRepository criteriasRepository;
  final ModelRepository modelRepository;

  CrudModelController({
    required this.criteriasRepository,
    required this.modelRepository,
  });

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  List<Criteria> criterias = [];

  @override
  void onInit() {
    super.onInit();

    loadCriterias();
  }

  Future<void> loadCriterias() async {
    criterias = await criteriasRepository.getCriterias();
    update();
  }

  Future<void> save() async {
    if (formKey.currentState!.saveAndValidate()) {
      final value = formKey.currentState!.value;

      final ahpModel = AHPModel(
        id: const Uuid().v4(),
        title: value['name'],
        description: value['desc'],
        dateTime: DateTime.now(),
        criterias: criterias.map((e) => e.toCompact()).toList(),
      );

      LogHelper.instance.debug(message: "Model $ahpModel");

      modelRepository.saveModel(ahpModel);

      Get.offAllNamed(Routes.selection);
    }
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
