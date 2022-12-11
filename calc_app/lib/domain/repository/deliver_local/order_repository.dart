import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getAllOrders();

  Future<bool> createOrder({
    required OrderEntity orderEntity,
  });

  Future<bool> deleteOrderById({
    required String id,
  });

  Future<OrderEntity> getOrderById({
    required String id,
  });

  Future<bool> updateBodyOrderById({
    required String id,
    required String name,
    required String description,
    required DateTime edit,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
  });

  Future<bool> createComponent({
    required ComponentEntity componentEntity,
    required String idOrder,
    required DateTime edit,
  });

  Future<bool> deleteComponent({
    required String idOrder,
    required String idComponent,
  });

  Future<bool> updateComponentByIdInOrder({
    required ComponentEntity componentEntity,
  });

  Future<ComponentEntity> getComponentById({
    required String idComponent,
  });

  Future<List<ComponentEntity>> getComponentsById({
    required List<String> idComponents,
  });
}
