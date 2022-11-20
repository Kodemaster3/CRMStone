import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/domain/usecases/get_all_orders.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetAllOrders getAllOrders;

  OrderBloc({required this.getAllOrders}) : super(OrderInitial()) {
    String orderCashId = '';

    on<OrderLoadingEvent>((event, emit) async {
      // dev.log('OrderLoadingEvent is makes');

      emit(OrderLoading());
      final orders = await getAllOrders.orderRepository.getAllOrders();
      // dev.log('getAllOrders.orderRepository.getAllOrders() work');

      emit(OrdersLoaded(orders: orders));
    });
    on<OrderCreateEvent>((event, emit) async {
      final result = await getAllOrders.orderRepository
          .createNewOrder(name: event.name, description: event.description);
      // dev.log(result.toString());

      //TODO: implement flag
      emit(OrderAdded(flag: result));

      emit(OrderLoading());
      final orders = await getAllOrders.orderRepository.getAllOrders();
      emit(OrdersLoaded(orders: orders));
    });
    on<OrderViewWithComponentEvent>(
      (event, emit) async {
        emit(OrderLoading());
        final order = await getAllOrders.orderRepository
            .getOrderByIdForEdit(id: event.id);
        orderCashId = order.id;

        order.component.isNotEmpty
            ? emit(OrderViewWithComponent(order: order))
            : emit(OrderViewWithEmptyListComponent(order: order));
      },
    );
    on<ComponentOrderCreateEvent>(
      (event, emit) async {
        emit(OrderLoading());
        final flag = await getAllOrders.orderRepository.createComponent(
            name: event.name,
            material: event.material,
            height: event.height,
            length: event.length,
            quantity: event.quantity,
            weightPerCubMeter: event.weightPerCubMeter,
            width: event.width,
            pricePerCubMeter: event.pricePerCubMeter,
            idOrder: orderCashId);

        final order = await getAllOrders.orderRepository
            .getOrderByIdForEdit(id: orderCashId);

        emit(OrderViewWithComponent(order: order));
      },
    );

    on<OrderEditingEvent>(
      (event, emit) async {
        // dev.log(event.id);
        emit(OrderLoading());
        final order = await getAllOrders.orderRepository
            .getOrderByIdForEdit(id: event.id);
        emit(OrderLoaded(order: order));
      },
    );

    on<OrderUpdateEvent>(
      (event, emit) async {
        // dev.log('u be in on<OrderUpdateEvent>');
        emit(OrderLoading());
        final flag = await getAllOrders.orderRepository.updateBodyOrderById(
            id: event.id, name: event.name, description: event.description);

        //TODO: implement message on screen
        if (flag) {
          emit(
            OrderOperationSuccess(message: '${event.name} be changed Success'),
          );
        }
      },
    );
  }
}
