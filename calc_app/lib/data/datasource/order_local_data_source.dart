import 'dart:convert';

import 'package:calc_app/data/models/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OrderLocalDataSource {
  Future<List<OrderModel>> getLastOrderFromCache();
  Future<void> ordersToCache(List<OrderModel> order);
}

const CACHED_DELIVERS_LIST = 'CACHED_DELIVERS_LIST';

class OrderLocalDataSourceImpl extends OrderLocalDataSource {
  final SharedPreferences sharedPreferences;

  OrderLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<OrderModel>> getLastOrderFromCache() {
    final jsonDeliverList =
        sharedPreferences.getStringList(CACHED_DELIVERS_LIST) ?? [];
    return Future.value(jsonDeliverList
        .map((order) => OrderModel.fromJson(json.decode(order)))
        .toList());
  }

  @override
  Future<void> ordersToCache(List<OrderModel> orders) {
    final List<String> jsonOrderList =
        orders.map((order) => json.encode(order.toJson())).toList();

    sharedPreferences.setStringList(CACHED_DELIVERS_LIST, jsonOrderList);
    return Future.value(jsonOrderList);
  }
}
