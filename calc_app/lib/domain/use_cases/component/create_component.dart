import 'dart:math';

import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class CreateComponent {
  final OrderRepository orderRepository;

  CreateComponent(this.orderRepository);

  Future<bool> call(
      {required String name,
      required String material,
      required double height,
      required double length,
      required int quantity,
      required double weightPerCubMeter,
      required double width,
      required double pricePerCubMeter,
      required String idOrder}) async {
    final component = ComponentEntity(
        name: name,
        id: newId(),
        material: material,
        height: height,
        length: length,
        quantity: quantity,
        weightPerCubMeter: weightPerCubMeter,
        width: width,
        pricePerCubMeter: pricePerCubMeter);

    return await orderRepository.createComponent(
        componentEntity: component, idOrder: idOrder);
  }

  String newId() {
    String id = Random().nextInt(999999).toString();
    final now = DateTime.now().microsecondsSinceEpoch.toString();
    while (id.length < 12) {
      id = '0$id';
    }

    return '$now$id';
  }
}