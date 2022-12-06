import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/size.dart';

class ComponentEntity {
  final String id;
  final String name;
  final String material;
  final double width;
  final double length;
  final double height;
  final double weightPerCubMeter;
  final int quantity;
  final double pricePerCubMeter;
  final DateEntity dateEntity;
  final Size size;

  ComponentEntity({
    required this.id,
    required this.name,
    required this.material,
    required this.height,
    required this.length,
    required this.quantity,
    required this.weightPerCubMeter,
    required this.width,
    required this.pricePerCubMeter,
    required this.dateEntity,
    required this.size,
  });
}
