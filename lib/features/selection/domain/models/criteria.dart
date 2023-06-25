import 'package:sekrut/features/selection/domain/models/sub_criteria.dart';

class Criteria {
  final int index;
  final int? order;
  final String title;
  final String description;
  final List<SubCriteria>? subcriterias;

  Criteria({
    required this.index,
    this.order,
    required this.title,
    required this.description,
    this.subcriterias,
  });
}
