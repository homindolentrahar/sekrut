import 'package:get/get.dart';
import 'package:sekrut/core/constant/app_boxes.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/data/repository/selection_repository.dart';
import 'package:sekrut/features/domain/models/ahp_model.dart';
import 'package:sekrut/features/domain/models/selection.dart';
import 'package:sekrut/util/helpers/box_helper.dart';

class SelectionController extends GetxController {
  final ModelRepository modelRepository;
  final SelectionRepository selectionRepository;

  SelectionController({
    required this.modelRepository,
    required this.selectionRepository,
  });

  late String username;
  late AHPModel model;
  List<Selection> selections = [];

  @override
  void onInit() {
    super.onInit();

    listenSelections();
    listenModel();

    getUsername();
  }

  void getUsername() {
    username = BoxHelper(name: AppBoxes.app).getValue(AppBoxes.usernameKey);

    update();
  }

  void listenModel() {
    modelRepository.listenModel().listen((data) {
      model = data;

      update();
    });
  }

  void listenSelections() {
    selectionRepository.getAllSelections().listen((list) {
      selections = list;

      update();
    });
  }
}
