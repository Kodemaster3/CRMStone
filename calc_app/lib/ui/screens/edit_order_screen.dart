import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditOrderScreen extends StatelessWidget {
  static const routeName = '/EditOrderScreen';
  const EditOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = '';
    String description = '';
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          name = state.order.name;
          description = state.order.description;
          return Scaffold(
            appBar: AppBar(
              title: Text(state.order.name),
              // automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                TextFormField(
                  controller: TextEditingController(text: name),
                  onChanged: (value) => name = value,
                  onFieldSubmitted: (value) => name = value,
                ),
                TextFormField(
                  controller: TextEditingController(text: description),
                  onChanged: (value) => description = value,
                  onFieldSubmitted: (value) => description = value,
                ),
                TextButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    //submit(update) order
                    BlocProvider.of<OrderBloc>(context).add(
                      OrderUpdateEvent(
                        id: state.order.id,
                        name: name,
                        description: description,
                      ),
                    );

                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                )
              ],
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
