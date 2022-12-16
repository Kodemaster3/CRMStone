import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/repository/order_local/order_repository.dart';

class GetComponentById {
  final OrderRepository orderRepository;

  GetComponentById(this.orderRepository);

  Future<ComponentEntity> call({required String idComponent}) async {
    return await orderRepository.getComponentById(idComponent: idComponent);
  }
}
