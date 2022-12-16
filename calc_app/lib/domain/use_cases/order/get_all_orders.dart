import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/repository/order_local/order_repository.dart';

class GetAllOrders {
  final OrderRepository orderRepository;

  GetAllOrders(this.orderRepository);

  Future<List<OrderEntity>> call() async {
    return await orderRepository.getAllOrders();
  }
}
