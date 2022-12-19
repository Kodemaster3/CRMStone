import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/order.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';

abstract class OrderState {
  const OrderState();
}

class OrderInitialState extends OrderState {}

class OrderLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<OrderEntity> orders;

  OrdersLoaded({required this.orders});
}

class OrderLoaded extends OrderState {
  final OrderEntity order;

  OrderLoaded({required this.order});
}

class OrderOperationSuccess extends OrderState {
  final String message;

  OrderOperationSuccess({required this.message});
}

class OrderViewWithComponent extends OrderState {
  final OrderEntity order;
  final List<ComponentEntity> components;

  OrderViewWithComponent({
    required this.order,
    required this.components,
  });
}

class OrderViewWithEmptyListComponent extends OrderState {
  final OrderEntity order;

  OrderViewWithEmptyListComponent({required this.order});
}

/// show empty fields
class ComponentCreatingFieldsState extends OrderState{
  final String idOrder;
  final String idComponent;
  final String name;
  final String description;
  final String materialId;
  final double width;
  final double length;
  final double height;
  final double weight;
  final int quantity;
  final UnitsLinear unitsLinear;
  final UnitsWeight unitsWeight;

  const ComponentCreatingFieldsState({
    required this.idOrder,
    required this.idComponent,
    required this.name,
    required this.description,
    required this.materialId,
    required this.width,
    required this.length,
    required this.height,
    required this.weight,
    required this.quantity,
    required this.unitsLinear,
    required this.unitsWeight,
  });
}

class ComponentUpdatingFieldState extends OrderState {
  final String idOrder;
  final String idComponent;
  final String name;
  final String description;
  final String materialId;
  final double width;
  final double length;
  final double height;
  final double weight;
  final int quantity;
  final UnitsLinear unitsLinear;
  final UnitsWeight unitsWeight;

  const ComponentUpdatingFieldState({
    required this.idOrder,
    required this.idComponent,
    required this.name,
    required this.description,
    required this.materialId,
    required this.width,
    required this.length,
    required this.height,
    required this.weight,
    required this.quantity,
    required this.unitsLinear,
    required this.unitsWeight,
  });
}
