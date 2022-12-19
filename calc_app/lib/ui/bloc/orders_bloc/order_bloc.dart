import 'dart:developer' as dev;

import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/domain/use_cases/component/component_use_case.dart';
import 'package:calc_app/domain/use_cases/order/order_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';

const String blocOrder = 'BLOC Order';

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
  }) : super(OrderInitialState()) {
    String _orderCashId = '';

    ///Emit all orders
    on<OrderLoadingEvent>((event, emit) async {
      dev.log('Active state is: OrderLoading in OrderLoadingEvent', name: blocOrder);
      emit(OrderLoading());

      final orders = await getAllOrders();
      dev.log('Active state is: OrdersLoaded in OrderLoadingEvent', name: blocOrder);
      emit(OrdersLoaded(orders: orders));
    });

    ///Create new order
    on<OrderCreateEvent>((event, emit) async {
      dev.log('Active state is: OrderLoading in OrderCreateEvent', name: blocOrder);
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
      dev.log('Active state is: OrdersLoaded in OrderCreateEvent', name: blocOrder);
      emit(OrdersLoaded(orders: orders));
      //TODO implement throw exception by each id number
    });

    ///Emit all orders and given choice variable when component list empty
    on<OrderViewWithComponentEvent>(
      (event, emit) async {
        dev.log('Active state is: OrderLoading in OrderViewWithComponentEvent', name: blocOrder);
        emit(OrderLoading());
        dev.log(event.id);
        final order = await getOrderById(id: event.id);
        _orderCashId = order.id;
        bool flag = order.component.isNotEmpty;
        flag ? dev.log('Active state is: OrderViewWithComponent in OrderViewWithComponentEvent', name: blocOrder) :
        dev.log('Active state is: OrderViewWithEmptyListComponent in OrderViewWithComponentEvent', name: blocOrder);
        flag
            ? emit(OrderViewWithComponent(
                order: order,
                components:
                    await getComponentsById(listIdComponents: order.component)))
            : emit(OrderViewWithEmptyListComponent(order: order));
      },
    );

    ///Create component in selected order

    on<ComponentOrderCreatingEvent>((event, emit) async {
      dev.log('Active state is: OrderLoading in ComponentOrderCreatingEvent', name: 'BLOC Order');
      emit(OrderLoading());
      final idOrder = event.idOrder;
      const String idComponentEmptyField = '';
      const String nameEmptyField = '';
      const String descriptionEmptyField = '';
      const String materialIdEmptyField = 'empty';
      const double widthEmptyField = 0.0;
      const double lengthEmptyField = 0.0;
      const double heightEmptyField = 0.0;
      const double weightEmptyField = 0.0;
      const int quantityEmptyField = 0;
      const UnitsLinear unitsLinearDefault = UnitsLinear.meter;
      const UnitsWeight unitsWeightDefault = UnitsWeight.kilogram;
      dev.log('Active state is: ComponentCreatingFieldsState in ComponentOrderCreatingEvent', name: blocOrder);
      emit(ComponentCreatingFieldsState(
        idOrder: idOrder,
        idComponent: idComponentEmptyField,
        name: nameEmptyField,
        description: descriptionEmptyField,
        materialId: materialIdEmptyField,
        width: widthEmptyField,
        length: lengthEmptyField,
        height: heightEmptyField,
        weight: weightEmptyField,
        quantity: quantityEmptyField,
        unitsLinear: unitsLinearDefault,
        unitsWeight: unitsWeightDefault,
      ));
    });

    on<ComponentOrderCreateEvent>(
      (event, emit) async {
        dev.log('Active state is: OrderLoading in ComponentOrderCreateEvent', name: blocOrder);
        emit(OrderLoading());
        final response = await createComponent(
          idOrder: event.idOrder,
          name: event.name,
          description: event.description,
          materialId: event.materialId,
          width: event.width,
          length: event.length,
          height: event.height,
          weight: event.weight,
          unitsLinear: event.unitsLinear,
          unitsWeight: event.unitsWeight,
          quantity: event.quantity,
        );

        final order = await getOrderById(id: _orderCashId);
        if (response) {
          dev.log('Active state is: OrderViewWithComponent in ComponentOrderCreateEvent', name: blocOrder);
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
        dev.log('Active state is: OrderLoading in OrderViewByIdEvent', name: blocOrder);
        emit(OrderLoading());
        final order = await getOrderById(id: event.id);
        dev.log('Active state is: OrderLoaded in OrderViewByIdEvent', name: blocOrder);
        emit(OrderLoaded(order: order));
      },
    );

    on<OrderDeleteEvent>(
      (event, emit) async {
        dev.log('Active state is: OrderLoading in OrderDeleteEvent', name: blocOrder);
        emit(OrderLoading());
        final responce = await deleteOrder(id: event.id);
      },
    );

    on<OrderUpdateEvent>(
      (event, emit) async {
        dev.log('Active state is: OrderLoading in OrderUpdateEvent', name: blocOrder);
        emit(OrderLoading());
        final response = await updateOrder(
          id: event.id,
          name: event.name,
          description: event.description,
          width: event.width,
          length: event.length,
          height: event.height,
          unitsLinear: event.unitsLinear,
          unitsWeight: event.unitsWeight,
        );

        //TODO: implement message on screen
        if (response) {
          dev.log('Active state is: OrderOperationSuccess in OrderUpdateEvent', name: blocOrder);
          emit(
            OrderOperationSuccess(message: '${event.name} be changed Success'),
          );
        }
      },
    );

    on<ComponentOrderDeletedEvent>(
      (event, emit) async {
        dev.log('Active state is: OrderLoading in ComponentOrderDeletedEvent', name: blocOrder);
        emit(OrderLoading());
        final response = await deleteComponent(
            idOrder: _orderCashId, idComponent: event.idComponent);
        final order = await getOrderById(id: _orderCashId);
        if (response) {
          dev.log('Active state is: OrderViewWithComponent in ComponentOrderDeletedEvent', name: blocOrder);
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
            dev.log('Active state is: OrderLoading in ComponentOrderUpdatingEvent', name: blocOrder);
        emit(OrderLoading());
        final component =
        await getComponentById(idComponent: event.idComponent);

            dev.log('Active state is: ComponentUpdatingFieldState in ComponentOrderUpdatingEvent', name: blocOrder);
        emit(ComponentUpdatingFieldState(
          idOrder: event.idOrder,
          idComponent: component.id,
          name: component.name,
          description: component.description,
          materialId: component.materialId,
          width: component.size.width,
          length: component.size.length,
          height: component.size.length,
          weight: component.weight.weight,
          quantity: component.quantity,
          unitsLinear: component.size.unitsLinear,
          unitsWeight: component.weight.unitsWeight,
        ));
      },
    );

    on<ComponentOrderUpdatedEvent>(
      (event, emit) async {
        dev.log('Active state is: OrderLoading in ComponentOrderUpdatedEvent', name: blocOrder);
        emit(OrderLoading());
        final response = await updateComponent(
          idComponent: event.idComponent,
          name: event.name,
          description: event.description,
          materialId: event.material,
          width: event.width,
          length: event.length,
          height: event.height,
          weight: event.weight,
          quantity: event.quantity,
          unitsLinear: event.unitsLinear,
          unitsWeight: event.unitsWeight,
        );
      },
    );


  }
}
