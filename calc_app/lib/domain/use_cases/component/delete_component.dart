import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class DeleteComponent {
  final OrderRepository orderRepository;

  DeleteComponent(this.orderRepository);

  Future<bool> call({required String idOrder, required String idComponent}) async {
    return await orderRepository.deleteComponent(idOrder: idOrder, idComponent: idComponent);
  }
}