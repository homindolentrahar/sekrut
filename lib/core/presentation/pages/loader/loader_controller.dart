import 'package:get/get.dart';
import 'package:sekrut/core/constant/app_boxes.dart';
import 'package:sekrut/route/app_route.dart';
import 'package:sekrut/util/helpers/box_helper.dart';

class LoaderController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    final box = BoxHelper(name: AppBoxes.app);
    final username = box.getValue(AppBoxes.usernameKey);

    if (username != null) {
      // Navigate to Home
      Get.offAllNamed(Routes.selection);
    } else {
      // Navigate to Landing
      Get.offAllNamed(Routes.landing);
    }
  }
}
