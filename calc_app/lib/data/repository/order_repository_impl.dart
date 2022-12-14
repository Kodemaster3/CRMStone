import 'dart:developer' as dev;

import 'package:calc_app/data/datasource/order_local_data_source.dart';
import 'package:calc_app/data/models/order_model.dart';
import 'package:calc_app/data/repository/order_mapper.dart';
import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

const topPositionInList = 0;

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource localDataSource;
  final orderMapper = OrderMapper();

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<List<OrderEntity>> getAllOrders() async {
    try {
      final dataOrders = await localDataSource.getLastOrderFromCache();
      // dev.log(dataOrders.last.dateEntity.edit.toString());
      return dataOrders;
    } on Exception {
      dev.log('Exc in order repository, method getAllOrders()');
    }
    throw Exception('Exception in repository lvl data');
  }

  @override
  Future<OrderEntity> getOrderById({
    required String id,
  }) async {
    try {
      List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();
      for (var element in dataOrders) {
        if (element.id == id) {
          return element;
        }
      }
    } on Exception {
      dev.log(
          'Exc in order,repository method getOrderByIdEdit() when id is $id');
    }
    throw Exception('Exception in repository lvl data');
  }

  @override
  Future<bool> deleteOrderById({
    required String id,
  }) async {
    try {
      final List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();
      for (var element in dataOrders) {
        if (element.id == id) {
          dataOrders.remove(element);
          break;
        }
      }
      await localDataSource.ordersToCache(dataOrders);
      return true;
    } on Exception {
      dev.log(
          'Exc in order repository method deleteOrderById() when id is $id');
      return false;
    }
  }

  @override
  Future<bool> createOrder({
    required OrderEntity orderEntity,
  }) async {
    try {
      final List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();
      final List<String> oldId = dataOrders.map((e) => e.id).toList();
      if (oldId.contains(orderEntity.id)) {
        throw Exception('id is not unique');
      }
      dataOrders.insert(
          topPositionInList, orderMapper.orderEntityToDataModel(orderEntity));

      await localDataSource.ordersToCache(dataOrders);
      return true;
    } on Exception {
      dev.log('Exc in repository method createNewOrder()'
          ' when name is ${orderEntity.name}');
      return false;
    }
  }

  @override
  Future<bool> updateBodyOrderById({
    required String id,
    required String name,
    required String description,
    required double width,
    required double length,
    required double height,
    required DateTime edit,
    required UnitsLinear unitsLinear,
    required UnitsWeight unitsWeight,
  }) async {
    try {
      final List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();

      for (var element in dataOrders) {
        if (element.id == id) {
          final sizeModel = element.sizeModel.copyWith(
              width: width,
              height: height,
              length: length,
              unitsLinear: unitsLinear);
          final updatedTime = element.dateModel.copyWith(edit: edit);
          final updateOrder = element.copyWith(
            name: name,
            description: description,
            dateModel: updatedTime,
            sizeModel: sizeModel,
            unitsWeight: unitsWeight,
          );

          dataOrders.remove(element);
          dataOrders.insert(topPositionInList, updateOrder);
          await localDataSource.ordersToCache(dataOrders);
          return true;
        }
      }
      return false;
    } on Exception {
      dev.log('Exc in order repository, method updateOrderById()');
      return false;
    }
  }

  /// Load all orders, paired key in list components and push
  /// that entity component to same repository, where key that component
  /// must to be unique.
  @override
  Future<bool> createComponent({
    required ComponentEntity componentEntity,
    required String idOrder,
    required DateTime edit,
  }) async {
    try {
      final List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();

      checkIdForUniqueness(dataOrders, componentEntity.id);

      for (var element in dataOrders) {
        if (element.id == idOrder) {
          final List<String> updateListIdComponents = [];
          updateListIdComponents.addAll(element.component);
          updateListIdComponents.add(componentEntity.id);

          final updateData = element.dateModel.copyWith(edit: edit);
          final updateOrder = element.copyWith(
              component: updateListIdComponents, dateModel: updateData);
          dataOrders.remove(element);
          dataOrders.insert(topPositionInList, updateOrder);
          break;
        }
      }
      final newComponentData =
          orderMapper.componentEntityToDataModel(componentEntity);

      await localDataSource.componentToCache(
          componentEntity.id, newComponentData);
      await localDataSource.ordersToCache(dataOrders);
      return true;
    } on Exception {
      dev.log('Exc in order,repository method createComponent()'
          ' when id is $idOrder, in added component');
      return false;
    }
  }

  @override
  Future<bool> deleteComponent({
    required String idOrder,
    required String idComponent,
  }) async {
    try {
      final List<OrderModel> dataOrder =
          await localDataSource.getLastOrderFromCache();

      for (var element in dataOrder) {
        if (element.id == idOrder) {
          for (var elementComponent in element.component) {
            if (elementComponent == idComponent) {
              final updateDateOrder =
                  element.dateModel.copyWith(edit: DateTime.now());
              final List<String> updateComponentsList = [];

              updateComponentsList.addAll(element.component);
              updateComponentsList.remove(elementComponent);

              final updatedOrder = element.copyWith(
                  dateModel: updateDateOrder, component: updateComponentsList);
              dataOrder.remove(element);
              dataOrder.insert(topPositionInList, updatedOrder);

              await localDataSource.removeComponentFromCache(idComponent);
              await localDataSource.ordersToCache(dataOrder);
              return true;
            }
          }
        }
      }
      return false;
    } on Exception {
      dev.log('Exc in order rep, in method deleteComponent');
      return false;
    }
  }

  @override
  Future<bool> updateComponentByIdInOrder({
    required ComponentEntity componentEntity,
  }) async {
    try {
      final oldComponent = await localDataSource
          .getLastComponentFromCacheById(componentEntity.id);
      final updateDate = oldComponent.dateModel
          .copyWith(edit: componentEntity.dateEntity.edit);
      final weight = oldComponent.weightModel.copyWith(
        weight: componentEntity.weight.weight,
        unitsWeight: componentEntity.weight.unitsWeight,
      );

      final updateComponent = oldComponent.copyWith(
        name: componentEntity.name,
        material: componentEntity.material,
        description: componentEntity.description,
        sizeModel: orderMapper.sizeEntityToModel(componentEntity.size),
        weightModel: weight,
        quantity: componentEntity.quantity,
        weightPerCubMeter: componentEntity.weightPerCubMeter,
        pricePerCubMeter: componentEntity.pricePerCubMeter,
        dateModel: updateDate,
      );

      await localDataSource.componentToCache(
          componentEntity.id, updateComponent);
      return true;
    } on Exception {
      dev.log('Exc in order rep, in method updateComponentByIdInOrder');
      return false;
    }
  }

  @override
  Future<ComponentEntity> getComponentById({
    required String idComponent,
  }) async {
    try {
      final component =
          await localDataSource.getLastComponentFromCacheById(idComponent);
      return component;
    } on Exception {
      dev.log('Exc in order rep, in method getComponentById');
    }
    throw Exception('Exception in repository lvl data');
  }

  @override
  Future<List<ComponentEntity>> getComponentsById({
    required List<String> idComponents,
  }) async {
    try {
      final components =
          await localDataSource.getLastListComponentFromCacheById(idComponents);
      return components;
    } on Exception {
      dev.log('Exc in order rep, in method getComponentsById');
    }
    throw Exception('Exception in repository lvl data');
  }

  void checkIdForUniqueness(
      final List<OrderModel> dataOrders, String componentId) {
    for (var element in dataOrders) {
      final result = element.component;
      if (result.contains(componentId)) {
        throw Exception('id is not unique');
      }
    }
  }
}
