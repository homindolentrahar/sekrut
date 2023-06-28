import 'package:get/get.dart';
import 'package:sekrut/core/constant/app_constants.dart';
import 'package:sekrut/route/app_route.dart';
import 'package:sekrut/util/helpers/storage_helper.dart';

class LoaderController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    final username = StorageHelper.instance.read<String>(
      AppConstants.usernameKey,
    );

    if (username != null) {
      // Navigate to Home
      Get.offAllNamed(Routes.selection);
    } else {
      // Navigate to Landing
      Get.offAllNamed(Routes.landing);
    }
  }
}
