import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_criteria.freezed.dart';

part 'sub_criteria.g.dart';

@freezed
sealed class SubCriteria with _$SubCriteria {
  const SubCriteria._();

  @JsonSerializable(explicitToJson: true)
  const factory SubCriteria({
    required String title,
    required String slug,
    required String description,
    double? value,
    required List<SubCriteriaOption> options,
  }) = _SubCriteria;

  factory SubCriteria.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaFromJson(json);

  SubCriteriaCompact toCompact() => SubCriteriaCompact(
        title: title,
        slug: slug,
        description: description,
        value: value,
      );

  SubCriteriaForm toForm() => SubCriteriaForm(
        title: title,
        slug: slug,
        description: description,
        value: value,
      );
}

@freezed
sealed class SubCriteriaOption with _$SubCriteriaOption {
  @JsonSerializable(explicitToJson: true)
  const factory SubCriteriaOption({
    double? value,
    required String title,
    required String description,
  }) = _SubCriteriaOption;

  factory SubCriteriaOption.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaOptionFromJson(json);
}

@freezed
sealed class SubCriteriaCompact with _$SubCriteriaCompact {
  @JsonSerializable(explicitToJson: true)
  const factory SubCriteriaCompact({
    required String title,
    required String slug,
    required String description,
    double? value,
  }) = _SubCriteriaCompact;

  factory SubCriteriaCompact.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaCompactFromJson(json);
}

@freezed
sealed class SubCriteriaForm with _$SubCriteriaForm {
  @JsonSerializable(explicitToJson: true)
  const factory SubCriteriaForm({
    required String title,
    required String slug,
    required String description,
    double? value,
    SubCriteriaOption? option,
  }) = _SubCriteriaForm;

  factory SubCriteriaForm.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaFormFromJson(json);
}
