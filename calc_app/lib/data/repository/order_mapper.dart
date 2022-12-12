import 'dart:developer' as dev;
import 'package:calc_app/data/models/component_model.dart';
import 'package:calc_app/data/models/order_model.dart';
import 'package:calc_app/data/models/date_model.dart';
import 'package:calc_app/data/models/size_model.dart';
import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/date.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/entities/size.dart';

class OrderMapper {
  OrderModel orderEntityToDataModel(OrderEntity orderEntity) {
    // final date = DateModel(create: orderEntity.dateEntity.create, edit: orderEntity.dateEntity.edit);
    // dev.log(date.toString());
    return OrderModel(
      id: orderEntity.id,
      name: orderEntity.name,
      description: orderEntity.description,
      component: orderEntity.component,
      dateModel: _dateEntityToModel(orderEntity.dateEntity),
      // dateModel: date,
      sizeModel: sizeEntityToModel(orderEntity.size),
    );
  }

  OrderEntity orderDataModelToEntity(OrderModel orderModel) {
    return OrderEntity(
      id: orderModel.id,
      name: orderModel.name,
      description: orderModel.description,
      component: orderModel.component,
      dateEntity: orderModel.dateEntity,
      size: orderModel.size,
    );
  }

  ComponentModel componentEntityToDataModel(ComponentEntity componentEntity) {
    return ComponentModel(
      name: componentEntity.name,
      id: componentEntity.id,
      description: componentEntity.description,
      material: componentEntity.material,
      unitsLinear: componentEntity.unitsLinear,
      unitsWeight: componentEntity.unitsWeight,
      quantity: componentEntity.quantity,
      weightPerCubMeter: componentEntity.weightPerCubMeter,
      pricePerCubMeter: componentEntity.pricePerCubMeter,
      dateModel: _dateEntityToModel(componentEntity.dateEntity),
      sizeModel: sizeEntityToModel(componentEntity.size),
    );
  }

  ComponentEntity componentDataModelToEntity(ComponentModel componentModel) {
    return ComponentEntity(
      name: componentModel.name,
      id: componentModel.id,
      description: componentModel.description,
      material: componentModel.material,
      unitsLinear: componentModel.unitsLinear,
      unitsWeight: componentModel.unitsWeight,
      quantity: componentModel.quantity,
      weightPerCubMeter: componentModel.weightPerCubMeter,
      pricePerCubMeter: componentModel.pricePerCubMeter,
      dateEntity: componentModel.dateModel,
      size: componentModel.size,
    );
  }

  // DateEntity _dateModelToEntity(DateModel dateModel) {
  //   return DateEntity(create: dateModel.create, edit: dateModel.edit);
  // }

  DateModel _dateEntityToModel(DateEntity dateEntity) {
    return DateModel(create: dateEntity.create, edit: dateEntity.edit);
  }

  SizeModel sizeEntityToModel(Size size) {
    return SizeModel(
        width: size.width,
        length: size.length,
        height: size.height,
        unitsLinear: size.unitsLinear);
  }

}
