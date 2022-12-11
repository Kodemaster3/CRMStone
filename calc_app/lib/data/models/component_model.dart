import 'package:calc_app/data/models/date_model.dart';
import 'package:calc_app/data/models/size_model.dart';
import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'component_model.freezed.dart';

part 'component_model.g.dart';

@freezed
class ComponentModel with _$ComponentModel implements ComponentEntity {
  const ComponentModel._();

  const factory ComponentModel({
    required String name,
    required String id,
    required String description,
    required String material,
    required int quantity,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
    required double weightPerCubMeter,
    required double pricePerCubMeter,
    required DateModel dateModel,
    required SizeModel sizeModel,
  }) = _ComponentModel;

  factory ComponentModel.fromJson(Map<String, dynamic> json) =>
      _$ComponentModelFromJson(json);

  @override
  DateEntity get dateEntity => DateModel(
        create: dateModel.create,
        edit: dateModel.edit,
      );

  @override
  Size get size => SizeModel(
        width: sizeModel.width,
        length: sizeModel.length,
        height: sizeModel.height,
        unitsLinear: sizeModel.unitsLinear,
      );
}
