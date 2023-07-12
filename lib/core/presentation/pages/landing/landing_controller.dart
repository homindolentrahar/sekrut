import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sekrut/core/constant/app_boxes.dart';
import 'package:sekrut/features/data/repository/criterias_repository.dart';
import 'package:sekrut/features/domain/models/intensity.dart';
import 'package:sekrut/route/app_route.dart';
import 'package:sekrut/util/helpers/ahp_calculation.dart';

class LandingController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  void onInit() async {
    super.onInit();

    final criterias = await Get.find<CriteriasRepository>().getCriterias();
    final calculation = AHPCalculation(
      list: [],
      intensities: criterias.asMap().map(
            (key, value) => MapEntry(
              value.slug,
              criterias.map((e) => IntensityValue(slug: e.slug)).toList(),
            ),
          ),
    );

    calculation.firstMatrixAlt;
  }

  Future<void> saveUsername() async {
    if (formKey.currentState!.saveAndValidate()) {
      final username = formKey.currentState!.value['username'];

      final appBox = Get.find<Box>(tag: AppBoxes.app);
      appBox.put(AppBoxes.usernameKey, username);

      Get.offAllNamed(
        "${Routes.model}/${Routes.crud}",
        arguments: null,
      );
    }
  }
}
