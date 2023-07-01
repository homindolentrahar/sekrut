import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sekrut/features/selection/domain/models/alternatif.dart';
import 'package:sekrut/features/selection/domain/models/ahp_model.dart';

part 'selection.freezed.dart';
part 'selection.g.dart';

@freezed
sealed class Selection with _$Selection {
  const factory Selection({
    required String id,
    required String name,
    required String description,
    required int selectedAlternatives,
    required AHPModel model,
    required DateTime dateTime,
    required List<Alternatif> alternatives,
  }) = _Selection;

  factory Selection.empty() => Selection(
        id: "",
        name: "",
        description: "",
        selectedAlternatives: 0,
        model: AHPModel.empty(),
        dateTime: DateTime.now(),
        alternatives: [],
      );

  factory Selection.fromJson(Map<String, dynamic> json) =>
      _$SelectionFromJson(json);
}
