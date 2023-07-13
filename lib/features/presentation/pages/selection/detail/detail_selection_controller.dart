import 'package:get/get.dart';
import 'package:sekrut/features/data/repository/intensity_repository.dart';
import 'package:sekrut/features/domain/models/alternatif.dart';
import 'package:sekrut/features/domain/models/intensity.dart';
import 'package:sekrut/features/domain/models/selection.dart';

class DetailSelectionController extends GetxController {
  final Selection? data = Get.arguments["data"];
  final IntensityRepository intensityRepository;

  DetailSelectionController(this.intensityRepository);

  List<Alternatif> get sortedAlternatives {
    List<Alternatif> temp = [];

    temp = List.from(data?.alternatives ?? []);

    return temp..sort((a, b) => (b.result ?? 0).compareTo(a.result ?? 0));
  }
  List<IntensityForm> intensities = [];
  Map<String, List<IntensityValue>> mappedIntensities = {};

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  void loadData(){
    intensities = intensityRepository.getSavedIntensity();
    mappedIntensities = intensities
        .asMap()
        .map((key, value) => MapEntry(value.slug, value.values));
  }
}
