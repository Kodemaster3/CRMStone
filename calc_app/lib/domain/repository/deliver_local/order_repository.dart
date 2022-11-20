import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/order.dart';

abstract class OrderRepository {
  Future<List<OrderEntity>> getAllOrders();

  Future<bool> deleteOrderById({required String id});

  Future<OrderEntity> getOrderByIdForEdit({required String id});

  Future<bool> saveChangedOrderById({required OrderEntity order});

  Future<OrderEntity> updateOrderById({required String id});

  Future<bool> createNewOrder(
      {required String name, required String description});

  Future<bool> createComponent(
      {required String name,
      required String material,
      required double height,
      required double length,
      required int quantity,
      required double weightPerCubMeter,
      required double width,
      required double pricePerCubMeter,
      required String idOrder});
}
