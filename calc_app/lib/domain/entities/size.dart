import 'package:calc_app/domain/entities/units_linear.dart';

class Size {
  final int id;
  final double width;
  final double length;
  final double height;
  final UnitsLinear unitsLinear;

  Size(
      {required this.id,
      required this.width,
      required this.length,
      required this.height,
      required this.unitsLinear});
}

//width height length