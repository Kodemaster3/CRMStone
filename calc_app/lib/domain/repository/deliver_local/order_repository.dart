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
    required String id,
    required String name,
    required String description,
  });

  Future<bool> createComponent({
    required ComponentEntity componentEntity,
    required String idOrder,
  });

  Future<bool> deleteComponent({
    required String idOrder,
    required String idComponent,
  });

  Future<bool> updateComponentByIdInOrder({
    required String idComponent,
    required String name,
    required String material,
    required double height,
    required double length,
    required int quantity,
    required double weightPerCubMeter,
    required double width,
    required double pricePerCubMeter,
  });

  Future<ComponentEntity> getComponentById({
    required String idComponent,
  });

  Future<List<ComponentEntity>> getComponentsById({
    required List<String> idComponents,
  });
}
