import 'dart:math';

import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

import '../../entities/units_linear.dart';

final Size temptSize =
    Size(width: 0, length: 0, height: 0, unitsLinear: UnitsLinear.millimeter);

class CreateComponent {
  final OrderRepository orderRepository;

  CreateComponent(this.orderRepository);

  Future<bool> call({
    required String name,
    required String description,
    required String material,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
    //TODO: implement size fields!!!
    required int quantity,
    required double weightPerCubMeter,
    required double pricePerCubMeter,
    required String idOrder,
  }) async {
    final component = ComponentEntity(
      name: name,
      description: description,
      id: newId(),
      material: material,
      unitsLinear: unitsLinear,
      unitsWeight: unitsWeight,
      size: temptSize,
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
