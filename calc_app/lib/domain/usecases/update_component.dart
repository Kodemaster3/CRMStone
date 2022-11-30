import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class UpdateComponent {
  final OrderRepository orderRepository;

  UpdateComponent(this.orderRepository);

  ///focus by id component and ignore id order
  Future<bool> call({
    required String idComponent,
    required String name,
    required String material,
    required double height,
    required double length,
    required int quantity,
    required double weightPerCubMeter,
    required double width,
    required double pricePerCubMeter,
  }) async {
    return await orderRepository.updateComponentByIdInOrder(
        idComponent: idComponent,
        name: name,
        material: material,
        height: height,
        length: length,
        quantity: quantity,
        weightPerCubMeter: weightPerCubMeter,
        width: width,
        pricePerCubMeter: pricePerCubMeter);
  }
}
