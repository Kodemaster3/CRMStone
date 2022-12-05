import 'package:calc_app/data/datasource/order_local_data_source.dart';
import 'package:calc_app/data/repository/order_repository_impl.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';
import 'package:calc_app/domain/use_cases/component/create_component.dart';
import 'package:calc_app/domain/use_cases/order/create_order.dart';
import 'package:calc_app/domain/use_cases/order/delete_order.dart';
import 'package:calc_app/domain/use_cases/component/get_component_by_id.dart';
import 'package:calc_app/domain/use_cases/component/get_components_by_list_id.dart';
import 'package:calc_app/domain/use_cases/order/get_order_by_id.dart';
import 'package:calc_app/domain/use_cases/order/get_all_orders.dart';
import 'package:calc_app/domain/use_cases/component/update_component.dart';
import 'package:calc_app/domain/use_cases/order/update_order.dart';
import 'package:calc_app/domain/use_cases/component/delete_component.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/bloc/orders_bloc/order_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Bloc
  sl.registerFactory(
    () => OrderBloc(
      getAllOrders: sl(),
      deleteOrder: sl(),
      createOrder: sl(),
      createComponent: sl(),
      getOrderById: sl(),
      updateOrder: sl(),
      deleteComponent: sl(),
      updateComponent: sl(),
      getComponentById: sl(),
      getComponentsById: sl(),
    ),
  );

  /// Use Cases
  sl.registerLazySingleton(
    () => GetAllOrders(sl()),
  );
  sl.registerLazySingleton(
    () => DeleteOrder(sl()),
  );
  sl.registerLazySingleton(
    () => CreateOrder(sl()),
  );
  sl.registerLazySingleton(
    () => GetOrderById(sl()),
  );
  sl.registerLazySingleton(
    () => CreateComponent(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateOrder(sl()),
  );
  sl.registerLazySingleton(
    () => DeleteComponent(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateComponent(sl()),
  );
  sl.registerLazySingleton(
    () => GetComponentById(sl()),
  );
  sl.registerLazySingleton(
    () => GetComponentsByListId(sl()),
  );

  /// Repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      localDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
