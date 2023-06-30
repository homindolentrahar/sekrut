import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sekrut/features/selection/domain/models/sub_criteria.dart';

part 'criteria.freezed.dart';
part 'criteria.g.dart';

@freezed
class Criteria with _$Criteria {
  const Criteria._();

  const factory Criteria({
    required String title,
    required String slug,
    required String description,
    @JsonKey(name: "sub_criterias") required List<SubCriteria> subCriterias,
  }) = _Criteria;

  factory Criteria.fromJson(Map<String, dynamic> json) =>
      _$CriteriaFromJson(json);

  CriteriaCompact toCompact() => CriteriaCompact(
        title: title,
        slug: slug,
        description: description,
        subCriterias: subCriterias.map((e) => e.toCompact()).toList(),
      );
}

@freezed
class CriteriaCompact with _$CriteriaCompact {
  const factory CriteriaCompact({
    required String title,
    required String slug,
    required String description,
    @JsonKey(name: "sub_criterias")
    required List<SubCriteriaCompact> subCriterias,
  }) = _CriteriaCompact;

  factory CriteriaCompact.fromJson(Map<String, dynamic> json) =>
      _$CriteriaCompactFromJson(json);
}
