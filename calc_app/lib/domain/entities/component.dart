class ComponentEntity {
  final String name;
  final String id;
  final String material;
  final double width;
  final double length;
  final double height;
  final double weightPerCubMeter;
  int quantity;
  double pricePerCubMeter;

  ComponentEntity({
    required this.name,
    required this.id,
    required this.material,
    required this.height,
    required this.length,
    required this.quantity,
    required this.weightPerCubMeter,
    required this.width,
    required this.pricePerCubMeter,
  });
}