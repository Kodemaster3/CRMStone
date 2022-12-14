import 'package:calc_app/data/models/date_model.dart';
import 'package:calc_app/data/models/size_model.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';

part 'order_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: true)
class OrderModel with _$OrderModel implements OrderEntity {
  const OrderModel._();

  // @JsonSerializable(explicitToJson: true)
  const factory OrderModel({
    required String id,
    required String name,
    required String description,
    required SizeModel sizeModel,
    required List<String> component,
    required DateModel dateModel,
    required UnitsWeight unitsWeight,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

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
