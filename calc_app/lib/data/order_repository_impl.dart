import 'dart:developer' as dev;
import 'package:calc_app/data/datasource/order_local_data_source.dart';
import 'package:calc_app/data/models/component_model.dart';
import 'package:calc_app/data/models/order_model.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';
import 'package:calc_app/domain/usecases/create_component.dart';
import 'package:calc_app/domain/usecases/create_order.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderLocalDataSource localDataSource;

  OrderRepositoryImpl({required this.localDataSource});

  @override
  Future<List<OrderEntity>> getAllOrders() async {
    try {
      final dataOrders = await localDataSource.getLastOrderFromCache();
      //place save local data if data source from api
      return dataOrders;
    } on Exception {
      dev.log('Exc in order repository, method getAllOrders()');
    }
    throw Exception('Exception in repository lvl data');
  }

  @override
  Future<OrderEntity> getOrderByIdForEdit({required String id}) async {
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
  Future<bool> saveChangedOrderById({required OrderEntity order}) async {
    try {
      List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();
      for (var element in dataOrders) {
        if (element.id == order.id) {
          dataOrders.remove(element);
          final unitData = OrderModel(
              id: order.id,
              name: order.name,
              description: order.description,
              component: order.component);
          dataOrders.add(unitData);
          break;
        }
      }
      await localDataSource.ordersToCache(dataOrders);
      return true;
    } on Exception {
      dev.log(
          'Exc in order,repository method save..() when save id ${order.id}');
      return false;
    }
    // throw Exception('Exception in repository lvl data');
  }

  @override
  Future<bool> deleteOrderById({required String id}) async {
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
    // throw Exception('Exception in repository lvl data');
  }

  @override
  Future<bool> createNewOrder(
      {required String name, required String description}) async {
    // TODO: implement logic scan repo for search old ID
    try {
      List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();

      final newEntityOrder = CreateOrder().call(name, description);
      final newOrder = OrderModel(
          id: newEntityOrder.id,
          name: newEntityOrder.name,
          description: newEntityOrder.description,
          component: newEntityOrder.component);
      dataOrders.add(newOrder);
      await localDataSource.ordersToCache(dataOrders);
      return true;
    } on Exception {
      dev.log('Exc in repository method createNewOrder() when name is $name');
      return false;
    }
  }

  @override
  Future<bool> createComponent(
      {required String name,
      required String material,
      required double height,
      required double length,
      required int quantity,
      required double weightPerCubMeter,
      required double width,
      required double pricePerCubMeter,
      required String idOrder}) async {
    try {
      final newComponentEntity = CreateComponent().call(
          name: name,
          material: material,
          height: height,
          length: length,
          quantity: quantity,
          weightPerCubMeter: weightPerCubMeter,
          width: width,
          pricePerCubMeter: pricePerCubMeter);
      final newComponent = ComponentModel(
          name: newComponentEntity.name,
          id: newComponentEntity.id,
          material: newComponentEntity.material,
          height: newComponentEntity.height,
          length: newComponentEntity.length,
          quantity: newComponentEntity.quantity,
          weightPerCubMeter: newComponentEntity.weightPerCubMeter,
          width: newComponentEntity.width,
          pricePerCubMeter: newComponentEntity.pricePerCubMeter);
      late OrderModel order;

      List<OrderModel> dataOrders =
          await localDataSource.getLastOrderFromCache();

      for (var element in dataOrders) {
        if (element.id == idOrder) {
          order = element;
          order.component.add(newComponent);
          element = order;
          break;
        }
      }

      await localDataSource.ordersToCache(dataOrders);
      return true;
    } on Exception {
      dev.log(
          'Exc in order,repository method createComponent() when id is $idOrder, in added component');
      return false;
    }
  }

  @override
  Future<OrderEntity> updateOrderById({required String id}) {
    // TODO: implement updateOrderById
    throw UnimplementedError();
  }
}


// lock hear <---------------
