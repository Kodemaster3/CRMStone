import 'package:calc_app/domain/entities/order.dart';

abstract class OrderState {
  const OrderState();
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<OrderEntity> orders;
  OrdersLoaded({required this.orders});
}

class OrderLoaded extends OrderState {
  final OrderEntity order;
  OrderLoaded({required this.order});
}

class OrderAdded extends OrderState {
  final bool flag;
  //TODO: implement flag when can add
  OrderAdded({required this.flag});
}

class OrderViewWithComponent extends OrderState {
  final OrderEntity order;
  OrderViewWithComponent({required this.order});
}

class OrderViewWithEmptyListComponent extends OrderState {
  final OrderEntity order;
  OrderViewWithEmptyListComponent({required this.order});
}

class OrderEditing extends OrderState {
  final OrderEntity order;
  OrderEditing({required this.order});
}
