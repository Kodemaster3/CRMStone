import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/widgets/navigate/return_home.dart';
import 'package:calc_app/ui/screens/component_field_screen.dart';
import 'package:calc_app/ui/screens/edit_order_screen.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';


class ListViewComponentWidget extends StatelessWidget {
  const ListViewComponentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderViewWithComponent) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// That part call option to edit order and present describe

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Colors.white70,
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Project size:'),
                              Text(
                                'Length is ${state.order.size.length}',
                              ),
                              Text(
                                'Width  is ${state.order.size.width}',
                              ),
                              Text(
                                'description: ${state.order.description}',
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          BlocProvider.of<OrderBloc>(context)
                              .add(OrderViewByIdEvent(id: state.order.id));
                          Navigator.of(context)
                              .pushNamed(EditOrderScreen.routeName);
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ReturnHome(),
                    ),
                  ],
                ),
              ),

              /// That part give as the list our components in body

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.order.component.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        color: Colors.white70,
                        child: GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'id: ${state.components[index].idComponent}',
                                        ),
                                        Text(
                                          'Name: ${state.components[index].name}',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Quantity: ${state.components[index].quantity}',
                                        ),
                                        Text(
                                          'Material: ${state.components[index].materialId}',
                                        ),
                                        Text(
                                          'Description: ${state.components[index].description}',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    BlocProvider.of<OrderBloc>(context).add(
                                      ComponentOrderDeletedEvent(
                                          idComponent: state
                                              .components[index].idComponent),
                                    );
                                    scaffoldMessage(
                                        context, state.components[index].name);
                                  },
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            BlocProvider.of<OrderBloc>(context).add(
                              ComponentOrderUpdatingEvent(
                                idComponent:
                                    state.components[index].idComponent,
                                idOrder: state.order.id,
                              ),
                            );
                            Navigator.of(context)
                                .pushNamed(ComponentFieldScreen.routeName);
                          },
                        ),
                      );
                    }),
                  ),
                ),
              )
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Deleted component $text success")));
  }
}
