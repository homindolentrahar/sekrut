import 'package:sekrut/core/util/helper/json_helper.dart';
import 'package:sekrut/features/selection/domain/models/criteria.dart';

class CriteriasRepository {
  Future<List<Criteria>> getCriterias() async {
    final List<dynamic> response = await JsonHelper.readJson("criterias");

    return response.map((e) => Criteria.fromJson(e)).toList();
  }
}
