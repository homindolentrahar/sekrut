import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity.freezed.dart';

part 'intensity.g.dart';

@freezed
class Intensity with _$Intensity {
  const factory Intensity({
    required double value,
    required String title,
    required String description,
  }) = _Intensity;

  factory Intensity.fromJson(Map<String, dynamic> json) =>
      _$IntensityFromJson(json);
}

@freezed
class IntensityForm with _$IntensityForm {
  const factory IntensityForm({
    required String slug,
    required List<IntensityValue> values,
    required List<SubIntensityForm> subs,
  }) = _IntensityForm;

  factory IntensityForm.fromJson(Map<String, dynamic> json) =>
      _$IntensityFormFromJson(json);
}

@freezed
class IntensityValue with _$IntensityValue {
  const factory IntensityValue({
    required String slug,
    double? value,
  }) = _IntensityValue;

  factory IntensityValue.fromJson(Map<String, dynamic> json) =>
      _$IntensityValueFromJson(json);
}

@freezed
class SubIntensityForm with _$SubIntensityForm {
  const factory SubIntensityForm({
    required String slug,
    required List<IntensityValue> values,
  }) = _SubIntensityForm;

  factory SubIntensityForm.fromJson(Map<String, dynamic> json) =>
      _$SubIntensityFormFromJson(json);
}