import 'package:sekrut/features/domain/models/criteria.dart';
import 'package:sekrut/util/helpers/json_helper.dart';

class CriteriasRepository {
  Future<List<Criteria>> getCriterias() async {
    final List<dynamic> response = await JsonHelper.readJson("criterias");

    return response.map((e) => Criteria.fromJson(e)).toList();
  }
}
