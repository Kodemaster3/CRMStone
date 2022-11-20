import 'package:calc_app/data/datasource/order_local_data_source.dart';
import 'package:calc_app/data/order_repository_impl.dart';
import 'package:calc_app/domain/repository/deliver_local/order_repository.dart';
import 'package:calc_app/domain/usecases/get_all_orders.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/bloc/orders_bloc/order_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Bloc
  sl.registerFactory(
    () => OrderBloc(getAllOrders: sl()),
  );

  /// Use Cases
  sl.registerLazySingleton(
    () => GetAllOrders(sl()),
  );

  /// Repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(localDataSource: sl()),
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
