import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class UpdateOrder {
  final OrderRepository orderRepository;

  UpdateOrder(this.orderRepository);

  Future<bool> call({
    required String id,
    required String name,
    required String description,
  }) async {
    final timeEdit = DateTime.now();
    return await orderRepository.updateBodyOrderById(
        id: id, name: name, description: description, edit: timeEdit);
  }
}
