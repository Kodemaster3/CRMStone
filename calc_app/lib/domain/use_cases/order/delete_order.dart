import 'package:calc_app/domain/repository/order_local/order_repository.dart';

class DeleteOrder {
  final OrderRepository orderRepository;

  DeleteOrder(this.orderRepository);

  Future<bool> call({required String id}) async {
    return await orderRepository.deleteOrderById(id: id);
  }
}
