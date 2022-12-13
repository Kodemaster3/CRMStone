import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class UpdateOrder {
  final OrderRepository orderRepository;

  UpdateOrder(this.orderRepository);

  Future<bool> call({
    required String id,
    required String name,
    required String description,
    required double width,
    required double length,
    required double height,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
  }) async {
    final timeEdit = DateTime.now();
    return await orderRepository.updateBodyOrderById(
      id: id,
      name: name,
      description: description,
      width: width,
      length: length,
      height: height,
      edit: timeEdit,
      unitsLinear: unitsLinear,
      unitsWeight: unitsWeight,
    );
  }
}
