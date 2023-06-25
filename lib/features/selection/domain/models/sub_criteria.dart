import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_criteria.freezed.dart';
part 'sub_criteria.g.dart';

@freezed
sealed class SubCriteria with _$SubCriteria {
  const factory SubCriteria({
    int? order,
    required String title,
    required String description,
    required List<SubCriteriaOption> options,
  }) = _SubCriteria;

  factory SubCriteria.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaFromJson(json);
}

@freezed
sealed class SubCriteriaOption with _$SubCriteriaOption {
  const factory SubCriteriaOption({
    required int order,
    required int value,
    required String title,
    required String description,
  }) = _SubCriteriaOption;

  factory SubCriteriaOption.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaOptionFromJson(json);
}
