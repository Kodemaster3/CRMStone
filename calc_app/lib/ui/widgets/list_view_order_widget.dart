import 'dart:developer' as dev;

import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:calc_app/ui/screens/view_order_screen_with_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewOrderWidget extends StatelessWidget {
  const ListViewOrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrdersLoaded) {
          dev.log('state in ListViewWidget is work', name: 'ui');
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                          '$index id is: ${state.orders[index].id} an name is: ${state.orders[index].name} description is: ${state.orders[index].description}'),
                      Text(
                          'date created ${state.orders[index].dateEntity.create.toString()}'),
                      Text(
                          'date edited ${state.orders[index].dateEntity.edit.toString()}'),
                    ],
                  ),
                ),
                onTap: () {
                  BlocProvider.of<OrderBloc>(context).add(
                      OrderViewWithComponentEvent(id: state.orders[index].id));
                  Navigator.of(context)
                      .pushNamed(ViewOrderScreenWithListComponent.routeName);
                },
              );
            }),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
