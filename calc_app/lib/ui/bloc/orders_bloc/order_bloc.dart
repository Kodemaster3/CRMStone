import 'dart:developer' as dev;

import 'package:calc_app/domain/use_cases/component/create_component.dart';
import 'package:calc_app/domain/use_cases/order/create_order.dart';
import 'package:calc_app/domain/use_cases/component/delete_component.dart';
import 'package:calc_app/domain/use_cases/order/delete_order.dart';
import 'package:calc_app/domain/use_cases/component/get_component_by_id.dart';
import 'package:calc_app/domain/use_cases/component/get_components_by_list_id.dart';
import 'package:calc_app/domain/use_cases/order/get_order_by_id.dart';
import 'package:calc_app/domain/use_cases/component/update_component.dart';
import 'package:calc_app/domain/use_cases/order/update_order.dart';
import 'package:calc_app/domain/use_cases/order/get_all_orders.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final GetComponentsByListId getComponentsById;

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
    required this.getComponentsById,
  }) : super(OrderInitial()) {
    String _orderCashId = '';

    ///Emit all orders
    on<OrderLoadingEvent>((event, emit) async {
      emit(OrderLoading());
      final orders = await getAllOrders();
      emit(OrdersLoaded(orders: orders));
    });

    ///Create new order
    on<OrderCreateEvent>((event, emit) async {
      emit(OrderLoading());
      await createOrder.call(
        name: event.name,
        description: event.description,
        width: event.width,
        height: event.height,
        length: event.length,
        unitsLinear: event.unitsLinear,
        unitsWeight: event.unitsWeight,
      );
      final orders = await getAllOrders();
      emit(OrdersLoaded(orders: orders));
      //TODO implement throw exception by each id number
    });

    ///Emit all orders and given choice variable when component list empty
    on<OrderViewWithComponentEvent>(
      (event, emit) async {
        emit(OrderLoading());
        final order = await getOrderById(id: event.id);
        _orderCashId = order.id;

        order.component.isNotEmpty
            ? emit(OrderViewWithComponent(
                order: order,
                components:
                    await getComponentsById(listIdComponents: order.component)))
            : emit(OrderViewWithEmptyListComponent(order: order));
      },
    );

    ///Create component in selected order
    on<ComponentOrderCreateEvent>(
      (event, emit) async {
        emit(OrderLoading());
        final response = await createComponent(
          name: event.name,
          description: event.description,
          material: event.material,
          unitsLinear: event.unitsLinear,
          unitsWeight: event.unitsWeight,
          quantity: event.quantity,
          weightPerCubMeter: event.weightPerCubMeter,
          pricePerCubMeter: event.pricePerCubMeter,
          idOrder: _orderCashId,
        );

        final order = await getOrderById(id: _orderCashId);
        if (response) {
          emit(OrderViewWithComponent(
            order: order,
            components:
                await getComponentsById(listIdComponents: order.component),
          ));
        }
        //TODO implement throw exception by each id number
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
        final response = await updateOrder(
          id: event.id,
          name: event.name,
          description: event.description,
          unitsLinear: event.unitsLinear,
          unitsWeight: event.unitsWeight,
        );

        //TODO: implement message on screen
        if (response) {
          emit(
            OrderOperationSuccess(message: '${event.name} be changed Success'),
          );
        }
      },
    );

    on<ComponentOrderDeletedEvent>(
      (event, emit) async {
        emit(OrderLoading());
        final response = await deleteComponent(
            idOrder: _orderCashId, idComponent: event.idComponent);
        final order = await getOrderById(id: _orderCashId);
        // final List<ComponentEntity> components =
        //     await getComponentsById(listIdComponents: order.component);
        if (response) {
          emit(OrderViewWithComponent(
            order: order,
            components:
                await getComponentsById(listIdComponents: order.component),
          ));
        }
      },
    );

    on<ComponentOrderUpdatedEvent>(
      (event, emit) async {
        emit(OrderLoading());
        final response = await updateComponent(
            idComponent: event.idComponent,
            name: event.name,
            description: event.description,
            material: event.material,
            unitsLinear: event.unitsLinear,
            unitsWeight: event.unitsWeight,
            quantity: event.quantity,
            weightPerCubMeter: event.weightPerCubMeter,
            pricePerCubMeter: event.pricePerCubMeter);

        final order = await getOrderById(id: _orderCashId);
        // final List<ComponentEntity> components =
        //     await getComponentsById(listIdComponents: order.component);
        if (response) {
          emit(OrderViewWithComponent(
            order: order,
            components:
                await getComponentsById(listIdComponents: order.component),
          ));
        }
      },
    );

    on<ComponentOrderUpdatingEvent>(
      (event, emit) async {
        emit(OrderLoading());
        final component =
            await getComponentById(idComponent: event.idComponent);

        emit(ComponentEditingField(
          componentEntity: component,
          idOrder: _orderCashId,
        ));
      },
    );
  }
}
