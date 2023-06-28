import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sekrut/core/constant/app_constants.dart';
import 'package:sekrut/features/selection/data/repository/criterias_repository.dart';

abstract class AppModule {
  static void inject() {
    Get.put<GetStorage>(
      GetStorage(AppConstants.appStorage),
      tag: AppConstants.appStorage,
      permanent: true,
    );

    Get.put<CriteriasRepository>(CriteriasRepository());
  }
}
