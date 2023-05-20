import 'dart:convert';

import 'package:calc_app/data/models/component_model.dart';
import 'package:calc_app/data/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_ORDER_LIST = 'CACHED_ORDER_LIST';

abstract class OrderLocalDataSource {
  Future<List<OrderModel>> getLastOrderFromCache();

  Future<void> ordersToCache(List<OrderModel> orders);

  Future<List<ComponentModel>> getLastListComponentFromCacheById(
      List<String> listId);

  Future<void> componentToCache(
      String idComponentKey, ComponentModel componentModel);

  Future<void> removeComponentFromCache(String idComponentKey);

  Future<ComponentModel> getLastComponentFromCacheById(String idComponentKey);
}


class OrderLocalDataSourceImpl extends OrderLocalDataSource {
  final SharedPreferences sharedPreferences;

  OrderLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<OrderModel>> getLastOrderFromCache() {
    final jsonOrderList =
        sharedPreferences.getStringList(CACHED_ORDER_LIST) ?? [];
    return Future.value(jsonOrderList
        .map((order) => OrderModel.fromJson(json.decode(order)))
        .toList());
  }

  @override
  Future<void> ordersToCache(List<OrderModel> orders) {
    final List<String> jsonOrderList =
        orders.map((order) => json.encode(order.toJson())).toList();

    sharedPreferences.setStringList(CACHED_ORDER_LIST, jsonOrderList);
    return Future.value(jsonOrderList);
  }

  @override
  Future<List<ComponentModel>> getLastListComponentFromCacheById(
      List<String> listId) {
    final List<String> jsonKeyComponents = [];
    for (var element in listId) {
      jsonKeyComponents.add(sharedPreferences.get(element) as String);
    }
    return Future.value(jsonKeyComponents
        .map((component) => ComponentModel.fromJson(json.decode(component)))
        .toList());
  }

  @override
  Future<void> componentToCache(
      String idComponentKey, ComponentModel componentModel) {
    final jsonComponent = json.encode(componentModel.toJson());
    sharedPreferences.setString(idComponentKey, jsonComponent);
    return Future.value(jsonComponent);
  }

  @override
  Future<void> removeComponentFromCache(String idComponentKey) {
    return sharedPreferences.remove(idComponentKey);
  }

  @override
  Future<ComponentModel> getLastComponentFromCacheById(String idComponentKey) {
    final component = sharedPreferences.getString(idComponentKey);

    return Future.value(ComponentModel.fromJson(json.decode(component!)));
  }
}
