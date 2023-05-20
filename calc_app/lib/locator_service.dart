import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calc_app/data/models/datasource/material_local_data_source.dart';
import 'package:calc_app/data/models/datasource/order_local_data_source.dart';
import 'package:calc_app/data/repository/material_mapper.dart';
import 'package:calc_app/data/repository/material_repository_impl.dart';
import 'package:calc_app/data/repository/order_mapper.dart';
import 'package:calc_app/data/repository/order_repository_impl.dart';
import 'package:calc_app/domain/repository/material_local/material_repository.dart';
import 'package:calc_app/domain/repository/order_local/order_repository.dart';
import 'package:calc_app/domain/use_cases/material/material_use_case.dart';
import 'package:calc_app/domain/use_cases/order/order_use_case.dart';
import 'package:calc_app/domain/use_cases/component/component_use_case.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Bloc
  /// Order
  sl.registerFactory(() => OrderBloc(
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
      ));

  ///Material
  sl.registerFactory(() => MaterialBloc(
        createMaterialUseCase: sl(),
        updateMaterialUseCase: sl(),
        getAllMaterialUseCase: sl(),
        getMaterialByIdUseCase: sl(),
        deleteMaterialUseCase: sl(),
      ));

  /// Use Cases
  /// Order
  sl.registerLazySingleton(() => GetAllOrders(sl()));
  sl.registerLazySingleton(() => DeleteOrder(sl()));
  sl.registerLazySingleton(() => CreateOrder(sl()));
  sl.registerLazySingleton(() => GetOrderById(sl()));
  sl.registerLazySingleton(() => CreateComponent(sl()));
  sl.registerLazySingleton(() => UpdateOrder(sl()));
  sl.registerLazySingleton(() => DeleteComponent(sl()));
  sl.registerLazySingleton(() => UpdateComponent(sl()));
  sl.registerLazySingleton(() => GetComponentById(sl()));
  sl.registerLazySingleton(() => GetComponentsByListId(sl()));

  ///Material
  sl.registerLazySingleton(() => CreateMaterialUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMaterialUseCase(sl()));
  sl.registerLazySingleton(() => GetAllMaterialUseCase(sl()));
  sl.registerLazySingleton(() => GetMaterialByIdUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMaterialUseCase(sl()));

  /// Repository
  /// Order
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(
      localDataSource: sl(),
      orderMapper: OrderMapper(),
    ),
  );
  sl.registerLazySingleton<OrderLocalDataSource>(
    () => OrderLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  ///Material
  sl.registerLazySingleton<MaterialRepository>(() => MaterialRepositoryImpl(
        localDataSource: sl(),
        materialMapper: MaterialMapper(),
      ));
  sl.registerLazySingleton<MaterialLocalDataSource>(
    () => MaterialLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
