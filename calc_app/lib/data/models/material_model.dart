import 'package:calc_app/domain/entities/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'material_model.freezed.dart';

part 'material_model.g.dart';

@freezed
class MaterialModel with _$MaterialModel implements MaterialEntity {
  const MaterialModel._();

  const factory MaterialModel({
    required String id,
    required String name,
    required double weightPerCubMeter,
    required double pricePerCubMeter,
  }) = _MaterialModel;

  factory MaterialModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialModelFromJson(json);

}