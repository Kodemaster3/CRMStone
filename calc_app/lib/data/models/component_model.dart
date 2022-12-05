import 'package:calc_app/domain/entities/component.dart';

class ComponentModel extends ComponentEntity {
  ComponentModel(
      {required String name,
      required String id,
      required String material,
      required double height,
      required double length,
      required int quantity,
      required double weightPerCubMeter,
      required double width,
      required double pricePerCubMeter})
      : super(
            name: name,
            id: id,
            material: material,
            height: height,
            length: length,
            quantity: quantity,
            weightPerCubMeter: weightPerCubMeter,
            width: width,
            pricePerCubMeter: pricePerCubMeter);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'material': material,
      'width': width,
      'length': length,
      'height': height,
      'weightPerCubMeter': weightPerCubMeter,
      'quantity': quantity,
      'pricePerCubMeter': pricePerCubMeter,
    };
  }

  factory ComponentModel.fromJson(Map<String, dynamic> map) {
    return ComponentModel(
      name: map['name'] ?? '',
      id: map['id'],
      material: map['material'] ?? '',
      width: map['width']?.toDouble() ?? 0.0,
      length: map['length']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
      weightPerCubMeter: map['weightPerCubMeter']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      pricePerCubMeter: map['pricePerCubMeter']?.toDouble() ?? 0.0,
    );
  }
}

//   String toJson() => json.encode(toMap());

//   factory NomenclatureModelRepository.fromJson(String source) =>
//       NomenclatureModelRepository.fromMap(json.decode(source));
// }
