import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';
import 'package:calc_app/domain/use_cases/order/create_order.dart';

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
    //TODO: implement size fields!!!
  }) async {
    final date = DateEntity(create: DateTime.now(), edit: DateTime.now());
    final updateComponent = ComponentEntity(
        id: idComponent,
        name: name,
        material: material,
        height: height,
        length: length,
        quantity: quantity,
        weightPerCubMeter: weightPerCubMeter,
        width: width,
        pricePerCubMeter: pricePerCubMeter,
        dateEntity: date,
        size: temptSize,
    );
    return await orderRepository.updateComponentByIdInOrder(
        componentEntity: updateComponent);
  }
}
