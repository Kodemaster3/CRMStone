import 'dart:developer' as dev;

import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/screens/component_field_screen.dart';
import 'package:calc_app/ui/screens/edit_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:calc_app/ui/widgets/navigate/return_home.dart';
// import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';

class ListViewComponentWidget extends StatelessWidget {
  const ListViewComponentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderViewWithComponent) {
          // dev.log('state in OrderViewWithComponent is work');
          return Column(
            children: [
              const Expanded(
                child: ReturnHome(),
              ),

              /// That part call option to edit order

              Expanded(
                child: GestureDetector(
                  child: Column(
                    children: [
                      Text(
                        'description: ${state.order.description}',
                      ),
                    ],
                  ),
                  onTap: () {
                    dev.log('message');
                    BlocProvider.of<OrderBloc>(context)
                        .add(OrderViewByIdEvent(id: state.order.id));
                    Navigator.of(context).pushNamed(EditOrderScreen.routeName);
                  },
                ),
              ),

              /// That part give as list our components in body

              Expanded(
                flex: 10,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: state.order.component.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'id: ${state.order.component[index].id}',
                                    ),
                                    Text(
                                      'Name: ${state.order.component[index].name}',
                                    ),
                                    Text(
                                      'Quantity: ${state.order.component[index].quantity}',
                                    ),
                                    Text(
                                      'Material: ${state.order.component[index].material}',
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        BlocProvider.of<OrderBloc>(context).add(
                                          ComponentOrderDeletedEvent(
                                              idComponent: state
                                                  .order.component[index].id),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () {
                              //TODO: implement edit field component
                              BlocProvider.of<OrderBloc>(context).add(
                                ComponentOrderUpdatingEvent(
                                    idOrder: state.order.id,
                                    idComponent:
                                        state.order.component[index].id),
                              );
                              Navigator.of(context)
                                  .pushNamed(ComponentFieldScreen.routeName);
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return circularProgressIndicator();
      },
    );
  }

  Widget circularProgressIndicator() {
    // dev.log('circularProgressIndicator in ListViewComponentWidget');
    return const CircularProgressIndicator();
  }
}
