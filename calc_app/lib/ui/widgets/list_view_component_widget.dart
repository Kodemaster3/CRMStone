import 'dart:developer' as dev;

import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
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
    final bloc = BlocProvider.of<OrderBloc>(context);
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderViewWithComponent) {
          dev.log('state in OrderViewWithComponent is work');
          return Column(
            children: [
              const Expanded(
                child: ReturnHome(),
              ),
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
                    //TODO: implement edit field order
                    bloc.add(OrderEditingEvent(id: state.order.id));
                    Navigator.of(context).pushNamed(EditOrderScreen.routeName);
                  },
                ),
              ),
              //TODO: need find solution with height low priority
              //ListViewComponentWidget(),
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
                                //TODO: add text field view entity component
                                Text(
                                  'count components: ${state.order.component.length}',
                                ),
                              ],
                            ),
                            onTap: () {
                              //TODO: implement edit field component
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
    dev.log('circularProgressIndicator in ListViewComponentWidget');
    return const CircularProgressIndicator();
  }
}
