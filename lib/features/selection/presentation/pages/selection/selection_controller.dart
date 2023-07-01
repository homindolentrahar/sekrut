import 'package:get/get.dart';
import 'package:sekrut/core/constant/app_constants.dart';
import 'package:sekrut/features/selection/data/repository/model_repository.dart';
import 'package:sekrut/features/selection/domain/models/ahp_model.dart';
import 'package:sekrut/util/helpers/ahp_calculation.dart';
import 'package:sekrut/util/helpers/log_helper.dart';
import 'package:sekrut/util/helpers/storage_helper.dart';

class SelectionController extends GetxController {
  final ModelRepository modelRepository;

  SelectionController({required this.modelRepository});

  late String username;
  late AHPModel model;

  @override
  void onInit() {
    super.onInit();

    getUsername();
    getModel();
  }

  void getUsername() {
    username =
        StorageHelper.instance.read<String>(AppConstants.usernameKey) ?? "";

    update();
  }

  void getModel() {
    model = modelRepository.getModel();
    final ahpHelper = AHPCalculation(list: model.criterias);

    LogHelper.instance.debug(
      message:
          "First: ${ahpHelper.firstMatrix}\nTotal 1st: ${ahpHelper.totalFirstMatrix}\nSecond: ${ahpHelper.secondMatrix}\nTotal 2nd: ${ahpHelper.totalSecondMatrix}\nPriority: ${ahpHelper.priorities}\nIs Consistence: ${ahpHelper.isConcistence}",
    );

    update();
  }
}
