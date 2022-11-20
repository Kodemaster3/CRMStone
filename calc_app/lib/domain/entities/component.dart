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

/* implement in repo

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'material': material,
      'width': width,
      'length': length,
      'height': height,
      'weightPerCubMeter': weightPerCubMeter,
      'quantity': quantity,
      'pricePerCubMeter': pricePerCubMeter,
    };
  }

  factory Nomenclature.fromMap(Map<String, dynamic> map) {
    return Nomenclature(
      name: map['name'] ?? '',
      material: map['material'] ?? '',
      width: map['width']?.toDouble() ?? 0.0,
      length: map['length']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
      weightPerCubMeter: map['weightPerCubMeter']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      pricePerCubMeter: map['pricePerCubMeter']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Nomenclature.fromJson(String source) =>
      Nomenclature.fromMap(json.decode(source));

  @override
  String toString() {
    return '$name and $pricePerCubMeter';
  }
  */
}
