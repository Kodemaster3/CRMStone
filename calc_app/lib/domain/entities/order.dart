import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/size.dart';


class OrderEntity {
  final String id;
  final String name;
  final String description;
  final Size size;
  final List<String> component;
  final DateEntity dateEntity;

  const OrderEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.size,
    required this.component,
    required this.dateEntity,
  });
}
