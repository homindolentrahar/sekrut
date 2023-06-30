import 'package:get/get.dart';
import 'package:sekrut/features/selection/data/repository/criterias_repository.dart';
import 'package:sekrut/features/selection/data/repository/model_repository.dart';
import 'package:sekrut/features/selection/presentation/pages/model/crud_model_controller.dart';

class CrudModelBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrudModelController>(
      () => CrudModelController(
        criteriasRepository: Get.find<CriteriasRepository>(),
        modelRepository: Get.find<ModelRepository>(),
      ),
    );
  }
}
