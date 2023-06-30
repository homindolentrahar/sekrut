import 'package:get/get.dart';
import 'package:sekrut/features/selection/data/repository/model_repository.dart';
import 'package:sekrut/features/selection/presentation/pages/selection/selection_controller.dart';

class SelectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectionController>(
      () => SelectionController(
        modelRepository: Get.find<ModelRepository>(),
      ),
    );
  }
}
