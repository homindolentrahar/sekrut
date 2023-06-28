import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sekrut/features/selection/domain/models/criteria.dart';

part 'alternatif.freezed.dart';
part 'alternatif.g.dart';

@freezed
sealed class Alternatif with _$Alternatif {
  const factory Alternatif({
    required String id,
    required String name,
    required String email,
    required String contact,
    double? result,
    required DateTime dateTime,
    required List<Criteria> criterias,
  }) = _Alternatif;

  factory Alternatif.fromJson(Map<String, dynamic> json) =>
      _$AlternatifFromJson(json);
}
