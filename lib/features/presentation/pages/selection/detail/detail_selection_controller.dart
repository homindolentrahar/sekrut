import 'package:get/get.dart';
import 'package:sekrut/features/domain/models/alternatif.dart';
import 'package:sekrut/features/domain/models/selection.dart';

class DetailSelectionController extends GetxController {
  final Selection? data = Get.arguments["data"];

  List<Alternatif> get sortedAlternatives {
    List<Alternatif> temp = [];

    temp = List.from(data?.alternatives ?? []);

    return temp..sort((a, b) => (b.result ?? 0).compareTo(a.result ?? 0));
  }
}
