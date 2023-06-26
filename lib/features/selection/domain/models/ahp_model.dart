import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sekrut/features/selection/domain/models/criteria.dart';

part 'ahp_model.freezed.dart';
part 'ahp_model.g.dart';

@freezed
sealed class AHPModel with _$AHPModel {
  const factory AHPModel({
    required String id,
    required String title,
    required String description,
    required DateTime dateTime,
    required List<Criteria> criterias,
  }) = _AHPModel;

  factory AHPModel.fromJson(Map<String, dynamic> json) =>
      _$AHPModelFromJson(json);
}
