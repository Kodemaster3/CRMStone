import 'package:calc_app/domain/entities/component.dart';
import 'package:calc_app/domain/entities/order.dart';

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

class ComponentEditingField extends OrderState {
  final ComponentEntity componentEntity;
  final String idOrder;

  const ComponentEditingField({
    required this.componentEntity,
    required this.idOrder,
  });
}
