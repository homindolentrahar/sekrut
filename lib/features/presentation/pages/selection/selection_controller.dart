import 'package:get/get.dart';
import 'package:sekrut/core/constant/app_boxes.dart';
import 'package:sekrut/features/data/repository/intensity_repository.dart';
import 'package:sekrut/features/data/repository/model_repository.dart';
import 'package:sekrut/features/data/repository/selection_repository.dart';
import 'package:sekrut/features/domain/models/ahp_model.dart';
import 'package:sekrut/features/domain/models/intensity.dart';
import 'package:sekrut/features/domain/models/selection.dart';
import 'package:sekrut/util/helpers/box_helper.dart';

class SelectionController extends GetxController {
  final ModelRepository modelRepository;
  final SelectionRepository selectionRepository;
  final IntensityRepository intensityRepository;

  SelectionController({
    required this.modelRepository,
    required this.selectionRepository,
    required this.intensityRepository,
  });

  String username = "";
  AHPModel model = AHPModel.empty();
  List<Selection> selections = [];
  Map<String, List<IntensityValue>> intensities = {};

  @override
  void onInit() {
    super.onInit();

    intensities = intensityRepository.getSavedIntensity().asMap().map(
          (key, value) => MapEntry(value.slug, value.values),
        );

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
