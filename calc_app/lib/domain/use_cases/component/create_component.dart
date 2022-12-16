import 'dart:math';

import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/entities/weight.dart';
import 'package:calc_app/domain/repository/order_local/order_repository.dart';

import '../../entities/units_linear.dart';

class CreateComponent {
  final OrderRepository orderRepository;

  CreateComponent(this.orderRepository);

  Future<bool> call({
    required String name,
    required String description,
    required String material,
    required double width,
    required double length,
    required double height,
    required double weight,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
    required int quantity,
    required double weightPerCubMeter,
    required double pricePerCubMeter,
    required String idOrder,
  }) async {
    final size = Size(
      width: width,
      length: length,
      height: height,
      unitsLinear: unitsLinear,
    );
    final weightEntity = Weight(weight: weight, unitsWeight: unitsWeight,);
    final component = ComponentEntity(
      name: name,
      description: description,
      id: newId(),
      material: material,
      weight: weightEntity,
      size: size,
      quantity: quantity,
      weightPerCubMeter: weightPerCubMeter,
      pricePerCubMeter: pricePerCubMeter,
      dateEntity: DateEntity(
        create: DateTime.now(),
        edit: DateTime.now(),
      ),
    );

    return await orderRepository.createComponent(
      componentEntity: component,
      idOrder: idOrder,
      edit: DateTime.now(),
    );
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
