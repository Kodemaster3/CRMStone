import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/repository/order_local/order_repository.dart';

class GetComponentsByListId {
  final OrderRepository orderRepository;

  GetComponentsByListId(this.orderRepository);

  Future<List<ComponentEntity>> call(
      {required List<String> listIdComponents}) async {
    return await orderRepository.getComponentsById(
        idComponents: listIdComponents);
  }
}
