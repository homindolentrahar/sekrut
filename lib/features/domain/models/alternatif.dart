import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sekrut/features/domain/models/criteria.dart';

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
    required List<CriteriaForm> criterias,
  }) = _Alternatif;

  factory Alternatif.fromJson(Map<String, dynamic> json) =>
      _$AlternatifFromJson(json);

  factory Alternatif.empty() => Alternatif(
        id: "",
        name: "",
        email: "",
        contact: "",
        dateTime: DateTime.now(),
        criterias: [],
      );
}
