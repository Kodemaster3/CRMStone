import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';
import 'package:calc_app/domain/use_cases/order/create_order.dart';

class UpdateComponent {
  final OrderRepository orderRepository;

  UpdateComponent(this.orderRepository);

  ///focus by id component and ignore id order
  Future<bool> call({
    required String idComponent,
    required String name,
    required String description,
    required String material,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
    //TODO: implement size fields!!!
    required int quantity,
    required double weightPerCubMeter,
    required double pricePerCubMeter,

  }) async {
    final date = DateEntity(create: DateTime.now(), edit: DateTime.now());
    final updateComponent = ComponentEntity(
      id: idComponent,
      name: name,
      description: description,
      material: material,
      unitsLinear: unitsLinear,
      unitsWeight: unitsWeight,
      size: temptSize,
      quantity: quantity,
      weightPerCubMeter: weightPerCubMeter,
      pricePerCubMeter: pricePerCubMeter,
      dateEntity: date,

    );
    return await orderRepository.updateComponentByIdInOrder(
        componentEntity: updateComponent);
  }
}
