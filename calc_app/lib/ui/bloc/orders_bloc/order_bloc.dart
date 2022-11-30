import 'dart:developer' as dev;

import 'package:calc_app/domain/usecases/create_component.dart';
import 'package:calc_app/domain/usecases/create_order.dart';
import 'package:calc_app/domain/usecases/delete_component.dart';
import 'package:calc_app/domain/usecases/delete_order.dart';
import 'package:calc_app/domain/usecases/get_component_by_id.dart';
import 'package:calc_app/domain/usecases/get_order_by_id.dart';
import 'package:calc_app/domain/usecases/update_component.dart';
import 'package:calc_app/domain/usecases/update_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/domain/usecases/get_all_orders.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetAllOrders getAllOrders;
  final DeleteOrder deleteOrder;
  final CreateOrder createOrder;
  final GetOrderById getOrderById;
  final CreateComponent createComponent;
  final UpdateOrder updateOrder;
  final DeleteComponent deleteComponent;
  final UpdateComponent updateComponent;
  final GetComponentById getComponentById;

  OrderBloc({
    required this.getAllOrders,
    required this.createOrder,
    required this.getOrderById,
    required this.createComponent,
    required this.deleteOrder,
    required this.updateOrder,
    required this.deleteComponent,
    required this.updateComponent,
    required this.getComponentById,
  }) : super(OrderInitial()) {
    String orderCashId = '';

    ///Emit all orders
    on<OrderLoadingEvent>((event, emit) async {
      emit(OrderLoading());
      final orders = await getAllOrders();
      emit(OrdersLoaded(orders: orders));
    });

    ///Create new order
    on<OrderCreateEvent>((event, emit) async {
      await createOrder(event.name, event.description);
    });

    ///Emit all orders and given choice variable when component list empty
    on<OrderViewWithComponentEvent>(
      (event, emit) async {
        emit(OrderLoading());
        final order = await getOrderById(id: event.id);
        orderCashId = order.id;
        order.component.isNotEmpty
            ? emit(OrderViewWithComponent(order: order))
            : emit(OrderViewWithEmptyListComponent(order: order));
      },
    );

    ///Create component in selected order
    on<ComponentOrderCreateEvent>(
      (event, emit) async {
        emit(OrderLoading());

        await createComponent(
          name: event.name,
          material: event.material,
          height: event.height,
          length: event.length,
          quantity: event.quantity,
          weightPerCubMeter: event.weightPerCubMeter,
          width: event.width,
          pricePerCubMeter: event.pricePerCubMeter,
          idOrder: orderCashId,
        );

        final order = await getOrderById(id: orderCashId);
        // final order = await getAllOrders.orderRepository
        //     .getOrderById(id: orderCashId);

        emit(OrderViewWithComponent(order: order));
      },
    );

    on<OrderViewByIdEvent>(
      (event, emit) async {
        emit(OrderLoading());
        final order = await getOrderById(id: event.id);
        emit(OrderLoaded(order: order));
      },
    );

    on<OrderDeleteEvent>(
      (event, emit) async {
        emit(OrderLoading());
        await deleteOrder(id: event.id);
      },
    );

    on<OrderUpdateEvent>(
      (event, emit) async {
        // dev.log('u be in on<OrderUpdateEvent>');
        emit(OrderLoading());
        final flag = await updateOrder(
          id: event.id,
          name: event.name,
          description: event.description,
        );

        //TODO: implement message on screen
        if (flag) {
          emit(
            OrderOperationSuccess(message: '${event.name} be changed Success'),
          );
        }
      },
    );

    on<ComponentOrderDeletedEvent>(
      (event, emit) async {
        emit(OrderLoading()); // ??
        await deleteComponent(
            idOrder: orderCashId, idComponent: event.idComponent);
        final order = await getOrderById(id: orderCashId);
        emit(OrderViewWithComponent(order: order));
      },
    );


    on<ComponentOrderUpdatedEvent>(
      (event, emit) async {
        emit(OrderLoading());
        await updateComponent(
            idComponent: event.idComponent,
            name: event.name,
            material: event.material,
            height: event.height,
            length: event.length,
            quantity: event.quantity,
            weightPerCubMeter: event.weightPerCubMeter,
            width: event.width,
            pricePerCubMeter: event.pricePerCubMeter);

        final order = await getOrderById(id: orderCashId);
        emit(OrderViewWithComponent(order: order));
      },
    );

    on<ComponentOrderUpdatingEvent>(
          (event, emit) async {
        emit(OrderLoading());
        final component = await getComponentById(idComponent: event.idComponent);

        emit(ComponentEditingField(componentEntity: component, idOrder: event.idOrder));
      },
    );
  }
}
