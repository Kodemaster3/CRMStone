import 'dart:math';

import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/size.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/entities/weight.dart';
import 'package:calc_app/domain/repository/order_local/order_repository.dart';

import '../../entities/units_linear.dart';

class CreateComponent {
  final OrderRepository orderRepository;

  CreateComponent(this.orderRepository);

  Future<bool> call({
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
    required String idOrder,
  }) async {
    final size = Size(
      width: width,
      length: length,
      height: height,
      unitsLinear: unitsLinear,
    );
    final weightEntity = Weight(weight: weight, unitsWeight: unitsWeight,);
    final component = ComponentEntity(
      name: name,
      description: description,
      id: newId(),
      material: material,
      weight: weightEntity,
      size: size,
      quantity: quantity,
      weightPerCubMeter: weightPerCubMeter,
      pricePerCubMeter: pricePerCubMeter,
      dateEntity: DateEntity(
        create: DateTime.now(),
        edit: DateTime.now(),
      ),
    );

    return await orderRepository.createComponent(
      componentEntity: component,
      idOrder: idOrder,
      edit: DateTime.now(),
    );
  }

  String newId() {
    String id = Random().nextInt(999999).toString();
    final now = DateTime.now().microsecondsSinceEpoch.toString();
    while (id.length < 12) {
      id = '0$id';
    }

    return '$now$id';
  }
}


class DeleteComponent {
  final OrderRepository orderRepository;

  DeleteComponent(this.orderRepository);

  Future<bool> call({required String idOrder, required String idComponent}) async {
    return await orderRepository.deleteComponent(idOrder: idOrder, idComponent: idComponent);
  }
}


class GetComponentById {
  final OrderRepository orderRepository;

  GetComponentById(this.orderRepository);

  Future<ComponentEntity> call({required String idComponent}) async {
    return await orderRepository.getComponentById(idComponent: idComponent);
  }
}


class GetComponentsByListId {
  final OrderRepository orderRepository;

  GetComponentsByListId(this.orderRepository);

  Future<List<ComponentEntity>> call(
      {required List<String> listIdComponents}) async {
    return await orderRepository.getComponentsById(
        idComponents: listIdComponents);
  }
}


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


