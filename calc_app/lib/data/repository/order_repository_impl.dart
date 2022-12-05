import 'dart:developer' as dev;

import 'package:calc_app/data/datasource/order_local_data_source.dart';
import 'package:calc_app/data/models/component_model.dart';
import 'package:calc_app/data/models/order_model.dart';
import 'package:calc_app/data/repository/order_mapper.dart';
import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderLocalDataSource localDataSource;
  final orderMapper = OrderMapper();

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<List<OrderEntity>> getAllOrders() async {
    try {
      final dataOrders = await localDataSource.getLastOrderFromCache();
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
      List<OrderModel> dataOrders =
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
      List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();
      final List<String> oldId = dataOrders.map((e) => e.id).toList();
      if (oldId.contains(orderEntity.id)) {
        throw Exception('id is not unique');
      }
      dataOrders.add(orderMapper.orderEntityToDataModel(orderEntity));
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
  }) async {
    try {
      List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();

      for (var element in dataOrders) {
        if (element.id == id) {
          final order = OrderModel(
              id: id,
              name: name,
              description: description,
              component: element.component);

          dataOrders.remove(element);
          dataOrders.add(order);
        }
      }
      await localDataSource.ordersToCache(dataOrders);
      return true;
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
  }) async {
    try {
      List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();

      for (var element in dataOrders) {
        final result = element.component;
        if (result.contains(componentEntity.id)) {
          throw Exception('id is not unique');
        }
      }
      for (var element in dataOrders) {
        if (element.id == idOrder) {
          element.component.add(componentEntity.id);
          break;
        }
      }
      await localDataSource.componentToCache(componentEntity.id,
          orderMapper.componentEntityToDataModel(componentEntity));
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
      List<OrderModel> dataOrder =
          await localDataSource.getLastOrderFromCache();

      for (var element in dataOrder) {
        if (element.id == idOrder) {
          for (var elementComponent in element.component) {
            if (elementComponent == idComponent) {
              element.component.remove(elementComponent);
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
    try {
      final updateComponent = ComponentModel(
          id: idComponent,
          name: name,
          material: material,
          height: height,
          length: length,
          quantity: quantity,
          weightPerCubMeter: weightPerCubMeter,
          width: width,
          pricePerCubMeter: pricePerCubMeter);

      await localDataSource.componentToCache(idComponent, updateComponent);
      return true;
    } on Exception {
      dev.log('Exc in order rep, in method updateComponentByIdInOrder');
      return false;
    }
  }

  @override
  Future<ComponentEntity> getComponentById(
      {required String idComponent}) async {
    try {
      final component =
          await localDataSource.getLastComponentFromCacheById(idComponent);
      // for (var order in dataOrders) {
      //   for (var component in order.component) {
      //     if (component.id == idComponent) {
      //       return component;
      //     }
      //   }
      // }
      return component;
    } on Exception {
      dev.log('Exc in order rep, in method getComponentById');
    }
    throw Exception('Exception in repository lvl data');
  }

  @override
  Future<List<ComponentEntity>> getComponentsById(
      {required List<String> idComponents}) async {
    try {
      final components =
          await localDataSource.getLastListComponentFromCacheById(idComponents);
      return components;
    } on Exception {
      dev.log('Exc in order rep, in method getComponentsById');
    }
    throw Exception('Exception in repository lvl data');
  }
}