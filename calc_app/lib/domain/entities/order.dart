import 'component.dart';

class OrderEntity {
  final String id;
  final String name;
  final String description;
  final List<ComponentEntity> component;

  OrderEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.component,
  });
}
