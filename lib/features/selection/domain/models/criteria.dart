import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sekrut/features/selection/domain/models/sub_criteria.dart';

part 'criteria.freezed.dart';
part 'criteria.g.dart';

@freezed
class Criteria with _$Criteria {
  const factory Criteria({
    int? order,
    required String title,
    required String description,
    @JsonKey(name: "sub_criterias") required List<SubCriteria> subCriterias,
  }) = _Criteria;

  factory Criteria.fromJson(Map<String, dynamic> json) =>
      _$CriteriaFromJson(json);
}
