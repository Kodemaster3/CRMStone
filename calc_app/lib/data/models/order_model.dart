import 'package:calc_app/data/models/component_model.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/entities/component.dart';

class OrderModel extends OrderEntity {
  OrderModel(
      {required String id,
      required String name,
      required String description,
      required List<ComponentEntity> component})
      : super(
            id: id, name: name, description: description, component: component);

  factory OrderModel.fromJson(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      component: List<ComponentModel>.from(
          map['component'].map((x) => ComponentModel.fromMap(x))),
    );
  }

  // factory DeliverModelRepository.fromJson(String source) =>
  //     DeliverModelRepository.fromMap(json.decode(source));

  // String toJson() => json.encode(toMap());

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'component': component,
    };
  }
}
