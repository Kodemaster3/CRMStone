import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/entities/weight.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';


class UpdateComponent {
  final OrderRepository orderRepository;

  UpdateComponent(this.orderRepository);

  ///focus by id component and ignore id order
  Future<bool> call({
    required String idComponent,
    required String name,
    required String description,
    required String material,
    required double width,
    required double length,
    required double height,
    required double weight,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
    required int quantity,
    required double weightPerCubMeter,
    required double pricePerCubMeter,
  }) async {
    final date = DateEntity(create: DateTime.now(), edit: DateTime.now());
    final size = Size(
      width: width,
      length: length,
      height: height,
      unitsLinear: unitsLinear,
    );
    final weightEntity = Weight(weight: weight, unitsWeight: unitsWeight,);
    final updateComponent = ComponentEntity(
      id: idComponent,
      name: name,
      description: description,
      material: material,
      weight: weightEntity,
      size: size,
      quantity: quantity,
      weightPerCubMeter: weightPerCubMeter,
      pricePerCubMeter: pricePerCubMeter,
      dateEntity: date,
    );
    return await orderRepository.updateComponentByIdInOrder(
        componentEntity: updateComponent);
  }
}
