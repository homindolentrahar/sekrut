import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/criterias_repository.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/presentation/pages/alternative/crud_alternative_controller.dart';

class CrudAlternativeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrudAlternativeController>(
      () => CrudAlternativeController(
        criteriaRepository: Get.find<CriteriasRepository>(),
        modelRepository: Get.find<ModelRepository>(),
      ),
    );
  }
}
