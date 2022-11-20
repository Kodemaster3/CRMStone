import 'dart:math';
import 'package:calc_app/domain/entities/order.dart';

class CreateOrder {
  OrderEntity call(String name, String description) {
    final OrderEntity orderEntity;
    orderEntity = OrderEntity(
        id: newId(), name: name, description: description, component: []);
    return orderEntity;
  }

  String newId() {
    String id = Random().nextInt(19999999).toString();
    while (id.length < 20) {
      id = '0$id';
    }
    return id;
  }
}
