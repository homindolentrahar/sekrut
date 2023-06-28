import 'package:get/get.dart';
import 'package:sekrut/features/selection/data/repository/criterias_repository.dart';
import 'package:sekrut/features/selection/presentation/pages/alternative/crud_alternative_controller.dart';

class CrudAlternativeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrudAlternativeController>(
      () => CrudAlternativeController(Get.find<CriteriasRepository>()),
    );
  }
}
