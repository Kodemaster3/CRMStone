import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/order.dart';

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
    required OrderEntity updateOrder,
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
