import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/data/repository/selection_repository.dart';
import 'package:sekrut/features/presentation/pages/selection/crud/crud_selection_controller.dart';

class CrudSelectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CrudSelectionController>(
      () => CrudSelectionController(
        modelRepository: Get.find<ModelRepository>(),
        selectionRepository: Get.find<SelectionRepository>(),
      ),
    );
  }
}
