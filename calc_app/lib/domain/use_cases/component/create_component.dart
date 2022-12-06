import 'dart:math';

import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

import '../../entities/units_linear.dart';

final Size temptSize = Size(
    width: 0, length: 0, height: 0, unitsLinear: UnitsLinear.millimeter);


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
      required String idOrder,
        //TODO: implement size fields!!!
      }) async {
    final component = ComponentEntity(
      name: name,
      id: newId(),
      material: material,
      height: height,
      length: length,
      quantity: quantity,
      weightPerCubMeter: weightPerCubMeter,
      width: width,
      pricePerCubMeter: pricePerCubMeter,
      dateEntity: DateEntity(
        create: DateTime.now(),
        edit: DateTime.now(),
      ),
      size: temptSize
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
