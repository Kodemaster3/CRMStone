
class OrderEntity {
  final String id;
  final String name;
  final String description;
  final List<String> component;

  OrderEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.component,
  });
}
