import 'dart:developer' as dev;
import 'dart:math';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class CreateOrder {
  final OrderRepository orderRepository;

  CreateOrder(this.orderRepository);

  Future<void> call({
    required String name,
    required String description,
    required double width,
    required double length,
    required double height,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
  }) async {
    final List<String> componentsId = [];
    final date = DateEntity(create: DateTime.now(), edit: DateTime.now());
    final size = Size(
      width: width,
      length: length,
      height: height,
      unitsLinear: unitsLinear,
    );
    final orderEntity = OrderEntity(
      id: newId(),
      name: name,
      description: description,
      size: size,
      component: componentsId,
      dateEntity: date,
    );
    // dev.log(orderEntity.dateEntity.toString());
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
