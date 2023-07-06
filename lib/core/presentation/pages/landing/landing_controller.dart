import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sekrut/core/constant/app_boxes.dart';
import 'package:sekrut/route/app_route.dart';

class LandingController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Future<void> saveUsername() async {
    if (formKey.currentState!.saveAndValidate()) {
      final username = formKey.currentState!.value['username'];

      final appBox = Get.find<Box>(tag: AppBoxes.app);
      appBox.put(AppBoxes.usernameKey, username);

      Get.offAllNamed("${Routes.model}/${Routes.crud}");
    }
  }
}
