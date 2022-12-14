import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/entities/weight.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weight_model.freezed.dart';

part 'weight_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: true)
class WeightModel with _$WeightModel implements Weight {
  const WeightModel._();

  // @JsonSerializable(explicitToJson: true)
  const factory WeightModel({
    required double weight,
    required UnitsWeight unitsWeight,
  }) = _WeightModel;

  factory WeightModel.fromJson(Map<String, dynamic> json) =>
      _$WeightModelFromJson(json);

}