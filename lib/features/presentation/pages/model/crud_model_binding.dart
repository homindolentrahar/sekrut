import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/criterias_repository.dart';
import 'package:sekrut/features/data/repository/intensity_repository.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/presentation/pages/model/crud_model_controller.dart';

class CrudModelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrudModelController>(
      () => CrudModelController(
        criteriasRepository: Get.find<CriteriasRepository>(),
        modelRepository: Get.find<ModelRepository>(),
        intensityRepository: Get.find<IntensityRepository>(),
      ),
    );
  }
}
