import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sekrut/core/constant/app_boxes.dart';
import 'package:sekrut/features/data/repository/criterias_repository.dart';
import 'package:sekrut/features/data/repository/intensity_repository.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/data/repository/selection_repository.dart';
import 'package:sekrut/util/helpers/box_helper.dart';

abstract class AppModule {
  static void inject() {
    Get.put<Box>(
      Hive.box(AppBoxes.app),
      tag: AppBoxes.app,
      permanent: true,
    );
    Get.put<Box>(
      Hive.box(AppBoxes.model),
      tag: AppBoxes.model,
      permanent: true,
    );
    Get.put<Box>(
      Hive.box(AppBoxes.selections),
      tag: AppBoxes.selections,
      permanent: true,
    );
    Get.put<Box>(
      Hive.box(AppBoxes.intensities),
      tag: AppBoxes.intensities,
      permanent: true,
    );

    Get.put<CriteriasRepository>(CriteriasRepository());
    Get.put<ModelRepository>(
      ModelRepository(BoxHelper(name: AppBoxes.app)),
    );
    Get.put<SelectionRepository>(
      SelectionRepository(BoxHelper(name: AppBoxes.selections)),
    );
    Get.put<IntensityRepository>(
      IntensityRepository(BoxHelper(name: AppBoxes.intensities)),
    );
  }
}
