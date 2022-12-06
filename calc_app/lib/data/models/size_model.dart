import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'size_model.freezed.dart';

part 'size_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: true)
class SizeModel with _$SizeModel implements Size {
  const SizeModel._();

  // @JsonSerializable(explicitToJson: true)
  const factory SizeModel({
    required double width,
    required double length,
    required double height,
    required UnitsLinear unitsLinear,
  }) = _SizeModel;

  factory SizeModel.fromJson(Map<String, dynamic> json) =>
      _$SizeModelFromJson(json);

}
