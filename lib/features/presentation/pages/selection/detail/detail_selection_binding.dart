import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/intensity_repository.dart';
import 'package:sekrut/features/presentation/pages/selection/detail/detail_selection_controller.dart';

class DetailSelectionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => DetailSelectionController(Get.find<IntensityRepository>()));
  }
}
