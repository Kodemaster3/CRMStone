import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';

class ComponentEntity {
  final String id;
  final String name;
  final String description;
  final String material;
  final UnitsLinear unitsLinear;
  final UnitsWeight unitsWeight;
  final double weightPerCubMeter;
  final int quantity;
  final double pricePerCubMeter;
  final DateEntity dateEntity;
  final Size size;

  ComponentEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.material,
    required this.unitsLinear,
    required this.unitsWeight,
    required this.quantity,
    required this.weightPerCubMeter,
    required this.pricePerCubMeter,
    required this.dateEntity,
    required this.size,
  });
}
