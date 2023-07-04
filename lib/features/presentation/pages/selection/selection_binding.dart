import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/data/repository/selection_repository.dart';
import 'package:sekrut/features/presentation/pages/selection/selection_controller.dart';

class SelectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectionController>(
      () => SelectionController(
        modelRepository: Get.find<ModelRepository>(),
        selectionRepository: Get.find<SelectionRepository>(),
      ),
    );
  }
}
