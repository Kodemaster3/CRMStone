import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:calc_app/ui/widgets/navigate/return_home.dart';
import 'package:calc_app/ui/screens/component_field_screen.dart';
import 'package:calc_app/ui/widgets/list_view_component_widget.dart';

class ViewOrderScreenWithListComponent extends StatelessWidget {
  static const routeName = '/ViewOrderScreenWithListComponent';

  const ViewOrderScreenWithListComponent({Key? key}) : super(key: key);

  ///OrderViewWithComponentEvent
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderViewWithComponent) {
          // dev.log('ui layer state is not empty list component');
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Order name: ${state.order.name}'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    //navigate
                    Navigator.of(context)
                        .pushNamed(ComponentFieldScreen.routeName);
                  },
                ),
              ],
            ),
            body: const ListViewComponentWidget(),
          );
        }

        if (state is OrderViewWithEmptyListComponent) {
          // dev.log('ui layer state is empty list component');
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Order name: ${state.order.name}'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ReturnHome(),
                  const Text('The list Component is empty'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {

                      //navigate
                      Navigator.of(context)
                          .pushNamed(ComponentFieldScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return circularProgressIndicator();
      },
    );
  }

  Widget circularProgressIndicator() {
    // dev.log('CircularProgressIndicator in ViewOrderScreenWithListComponent');
    return const CircularProgressIndicator();
  }
}
