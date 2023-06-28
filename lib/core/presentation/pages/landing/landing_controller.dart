import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sekrut/core/constant/app_constants.dart';
import 'package:sekrut/route/app_route.dart';
import 'package:sekrut/util/helpers/storage_helper.dart';

class LandingController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  Future<void> saveUsername() async {
    if (formKey.currentState!.saveAndValidate()) {
      final username = formKey.currentState!.value['username'];

      await StorageHelper.instance.write(
        AppConstants.usernameKey,
        username,
      );

      Get.offAllNamed(Routes.model + Routes.create);
    }
  }
}
