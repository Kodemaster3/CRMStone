import 'dart:developer' as dev;

import 'package:calc_app/data/models/datasource/order_local_data_source.dart';
import 'package:calc_app/data/models/order_model.dart';
import 'package:calc_app/data/repository/order_mapper.dart';
import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/repository/order_local/order_repository.dart';

const topPositionInList = 0;

class OrderRepositoryImpl implements OrderRepository {
  final OrderLocalDataSource localDataSource;
  final OrderMapper orderMapper;

  const OrderRepositoryImpl(
      {required this.localDataSource, required this.orderMapper});

  @override
  Future<List<OrderEntity>> getAllOrders() async {
    try {
      dev.log('getAllOrders', name: 'DB(repository)');
      final dataOrders = await localDataSource.getLastOrderFromCache();
      return dataOrders;
    } on Exception {
      dev.log('Exc in order repository, method getAllOrders()', name: 'repos');
    }
    throw Exception('Exception in repository lvl data');
  }

  @override
  Future<OrderEntity> getOrderById({
    required String id,
  }) async {
    try {
      dev.log('getOrderById', name: 'DB(repository)');
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
      dev.log('deleteOrderById', name: 'DB(repository)');
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
      dev.log('createOrder', name: 'DB(repository)');
      final List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();
      final List<String> oldId = dataOrders.map((e) => e.id).toList();
      if (oldId.contains(orderEntity.id)) {
        throw Exception('id is not unique');
      }
      dataOrders.insert(
          topPositionInList, orderMapper.orderEntityToDataModel(orderEntity));
      await localDataSource.ordersToCache(dataOrders);
      dev.log(
          'Created order name: ${orderEntity.name},'
          ' id: ${orderEntity.id},'
          ' lengthOrderDB: ${dataOrders.length}',
          name: 'DB(repository)');
      return true;
    } on Exception {
      dev.log(
          'Exc in repository method createNewOrder()'
          ' when name is ${orderEntity.name}',
          name: 'repos');
      return false;
    }
  }

  @override
  Future<bool> updateBodyOrderById({
    required OrderEntity updateOrder,
  }) async {
    try {
      dev.log('updateBodyOrderById', name: 'DB(repository)');
      final List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();

      for (var element in dataOrders) {
        if (element.id == updateOrder.id) {
          dataOrders.remove(element);
          dataOrders.insert(topPositionInList,
              orderMapper.orderEntityToDataModel(updateOrder));
          // updateOrderModel);
          await localDataSource.ordersToCache(dataOrders);
          return true;
        }
      }
      return false;
    } on Exception {
      dev.log('Exc in order repository, method updateOrderById()',
          name: 'repos');
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
      dev.log('createComponent', name: 'DB(repository)');
      final List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();

      checkIdForUniqueness(dataOrders, componentEntity.idComponent);

      for (var element in dataOrders) {
        if (element.id == idOrder) {
          final List<String> updateListIdComponents = [];
          updateListIdComponents.addAll(element.component);
          updateListIdComponents.add(componentEntity.idComponent);

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
          componentEntity.idComponent, newComponentData);
      await localDataSource.ordersToCache(dataOrders);
      dev.log(
          'Created component name: ${componentEntity.name},'
          ' id: ${componentEntity.idComponent},'
          ' lengthOrder: ${dataOrders.length}',
          name: 'DB(repository)');
      return true;
    } on Exception {
      dev.log(
          'Exc in order,repository method createComponent()'
          ' when id is $idOrder, in added component',
          name: 'repos');
      return false;
    }
  }

  @override
  Future<bool> deleteComponent({
    required String idOrder,
    required String idComponent,
  }) async {
    try {
      dev.log('deleteComponent', name: 'DB(repository)');
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
      dev.log('Exc in order rep, in method deleteComponent', name: 'repos');
      return false;
    }
  }

  @override
  Future<bool> updateComponentByIdInOrder({
    required ComponentEntity componentEntity,
  }) async {
    try {
      dev.log('updateComponentByIdInOrder', name: 'DB(repository)');
      final oldComponent = await localDataSource
          .getLastComponentFromCacheById(componentEntity.idComponent);
      final updateDate = oldComponent.dateModel
          .copyWith(edit: componentEntity.dateEntity.edit);
      final weight = oldComponent.weightModel.copyWith(
        weight: componentEntity.weight.weight,
        unitsWeight: componentEntity.weight.unitsWeight,
      );

      final updateComponent = oldComponent.copyWith(
        name: componentEntity.name,
        materialId: componentEntity.materialId,
        description: componentEntity.description,
        sizeModel: orderMapper.sizeEntityToModel(componentEntity.size),
        weightModel: weight,
        quantity: componentEntity.quantity,
        dateModel: updateDate,
      );

      await localDataSource.componentToCache(
          componentEntity.idComponent, updateComponent);
      return true;
    } on Exception {
      dev.log('Exc in order rep, in method updateComponentByIdInOrder',
          name: 'repos');
      return false;
    }
  }

  @override
  Future<ComponentEntity> getComponentById({
    required String idComponent,
  }) async {
    try {
      dev.log('getComponentById', name: 'DB(repository)');
      final component =
          await localDataSource.getLastComponentFromCacheById(idComponent);
      return component;
    } on Exception {
      dev.log('Exc in order rep, in method getComponentById', name: 'repos');
    }
    throw Exception('Exception in repository lvl data');
  }

  @override
  Future<List<ComponentEntity>> getComponentsById({
    required List<String> idComponents,
  }) async {
    try {
      dev.log('getComponentsById', name: 'DB(repository)');
      final components =
          await localDataSource.getLastListComponentFromCacheById(idComponents);
      return components;
    } on Exception {
      dev.log('Exc in order rep, in method getComponentsById', name: 'repos');
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
