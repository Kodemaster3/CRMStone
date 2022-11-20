import 'dart:math';

import 'package:calc_app/domain/entities/component.dart';

class CreateComponent {
  ComponentEntity call(
      {required String name,
      required String material,
      required double height,
      required double length,
      required int quantity,
      required double weightPerCubMeter,
      required double width,
      required double pricePerCubMeter}) {
    return ComponentEntity(
        name: name,
        id: newId(),
        material: material,
        height: height,
        length: length,
        quantity: quantity,
        weightPerCubMeter: weightPerCubMeter,
        width: width,
        pricePerCubMeter: pricePerCubMeter);
  }

  String newId() {
    String id = Random().nextInt(19999999).toString();
    while (id.length < 22) {
      id = '0$id';
    }
    return id;
  }
}
