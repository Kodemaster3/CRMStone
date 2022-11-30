import 'dart:math';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class CreateOrder {
  final OrderRepository orderRepository;

  CreateOrder(this.orderRepository);

  Future<void> call(String name, String description) async {
    final OrderEntity orderEntity;
    orderEntity = OrderEntity(
        id: newId(), name: name, description: description, component: []);
    await orderRepository.createOrder(orderEntity: orderEntity);
    // return orderEntity;
  }

  String newId() {
    String id = Random().nextInt(19999999).toString();
    while (id.length < 20) {
      id = '0$id';
    }
    return id;
  }
}
