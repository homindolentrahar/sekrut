import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_criteria.freezed.dart';

part 'sub_criteria.g.dart';

@freezed
sealed class SubCriteria with _$SubCriteria {
  const SubCriteria._();

  const factory SubCriteria({
    required String title,
    required String slug,
    required String description,
    required List<SubCriteriaOption> options,
  }) = _SubCriteria;

  factory SubCriteria.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaFromJson(json);

  SubCriteriaCompact toCompact() => SubCriteriaCompact(
        title: title,
        slug: slug,
        description: description,
      );

  SubCriteriaForm toForm() => SubCriteriaForm(
        title: title,
        slug: slug,
        description: description,
      );
}

@freezed
sealed class SubCriteriaOption with _$SubCriteriaOption {
  const factory SubCriteriaOption({
    required int value,
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
    SubCriteriaOption? value,
  }) = _SubCriteriaForm;

  factory SubCriteriaForm.fromJson(Map<String, dynamic> json) =>
      _$SubCriteriaFormFromJson(json);
}
