import 'dart:developer' as dev;

import 'dart:math';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/repository/order_local/order_repository.dart';

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
      unitsWeight: unitsWeight,
    );
    dev.log('Create order name: ${orderEntity.name}', name: 'UseCase');
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

class DeleteOrder {
  final OrderRepository orderRepository;

  DeleteOrder(this.orderRepository);

  Future<bool> call({required String id}) async {
    return await orderRepository.deleteOrderById(id: id);
  }
}

class GetAllOrders {
  final OrderRepository orderRepository;

  GetAllOrders(this.orderRepository);

  Future<List<OrderEntity>> call() async {
    return await orderRepository.getAllOrders();
  }
}

class GetOrderById {
  final OrderRepository orderRepository;

  GetOrderById(this.orderRepository);

  Future<OrderEntity> call({required String id}) async {
    return await orderRepository.getOrderById(id: id);
  }
}

class UpdateOrder {
  final OrderRepository orderRepository;

  UpdateOrder(this.orderRepository);

  Future<bool> call({
    required String id,
    required String name,
    required String description,
    required double width,
    required double length,
    required double height,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
  }) async {
    final timeEdit = DateTime.now();
    final oldOrder = await orderRepository.getOrderById(id: id);
    final updateOrder = OrderEntity(
        id: id,
        name: name,
        description: description,
        size: Size(
            width: width,
            length: length,
            height: height,
            unitsLinear: unitsLinear),
        component: oldOrder.component,
        dateEntity:
            DateEntity(create: oldOrder.dateEntity.create, edit: timeEdit),
        unitsWeight: unitsWeight);

    return await orderRepository.updateBodyOrderById(updateOrder: updateOrder);
  }
}
