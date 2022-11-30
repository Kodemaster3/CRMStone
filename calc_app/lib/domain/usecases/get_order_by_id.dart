import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class GetOrderById {
  final OrderRepository orderRepository;

  GetOrderById(this.orderRepository);

  Future<OrderEntity> call({required String id}) async {
    return await orderRepository.getOrderById(id: id);
  }
}
