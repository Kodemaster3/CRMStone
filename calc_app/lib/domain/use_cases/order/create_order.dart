import 'dart:math';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class CreateOrder {
  final OrderRepository orderRepository;

  CreateOrder(this.orderRepository);

  Future<void> call(String name, String description) async {
    final OrderEntity orderEntity;
    final List<String> componentsId = [];
    orderEntity = OrderEntity(
        id: newId(),
        name: name,
        description: description,
        component: componentsId);
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
