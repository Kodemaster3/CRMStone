import 'package:calc_app/domain/entities/order.dart';

class OrderModel extends OrderEntity {
  OrderModel(
      {required String id,
      required String name,
      required String description,
      required List<String> component})
      : super(
            id: id, name: name, description: description, component: component);

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      component: List<String>.from(map['component']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'component': component,
    };
  }
}





