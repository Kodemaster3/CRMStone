import 'dart:developer' as dev;
import 'dart:math';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

final Size temptSize = Size(
    width: 0, length: 0, height: 0, unitsLinear: UnitsLinear.millimeter);

class CreateOrder {
  final OrderRepository orderRepository;

  CreateOrder(this.orderRepository);

  Future<void> call(String name, String description,
      //TODO: implement size fields!!!
      ) async {
    final List<String> componentsId = [];
    final date = DateEntity(create: DateTime.now(), edit: DateTime.now());
    final orderEntity = OrderEntity(
      id: newId(),
      name: name,
      description: description,
      component: componentsId,
      dateEntity: date,
      size: temptSize,
    );
    dev.log(orderEntity.dateEntity.toString());
    await orderRepository.createOrder(orderEntity: orderEntity);
  }

  String newId() {
    String id = Random().nextInt(9999).toString();
    final now = DateTime.now().microsecondsSinceEpoch.toString();
    while (id.length < 10) {
      id = '0$id';
    }
    return '$now$id';
  }
}
