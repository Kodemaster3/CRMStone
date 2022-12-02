import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';

class EditOrderScreen extends StatelessWidget {
  static const routeName = '/EditOrderScreen';

  EditOrderScreen({Key? key}) : super(key: key);

  final _fl = FieldLink();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          _fl.name = state.order.name;
          _fl.description = state.order.description;
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () {
                    BlocProvider.of<OrderBloc>(context).add(OrderDeleteEvent(id: state.order.id));
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                ),
              ],
              title: Text(state.order.name),
              // automaticallyImplyLeading: false,
            ),
            body: Column(
              children: [
                TextFormField(
                  controller: TextEditingController(text: _fl.name),
                  onChanged: (value) => _fl.name = value,
                  onFieldSubmitted: (value) => _fl.name = value,
                ),
                TextFormField(
                  controller: TextEditingController(text: _fl.description),
                  onChanged: (value) => _fl.description = value,
                  onFieldSubmitted: (value) => _fl.description = value
                ),
                TextButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    //submit(update) order
                    BlocProvider.of<OrderBloc>(context).add(
                      OrderUpdateEvent(
                        id: state.order.id,
                        name: _fl.name,
                        description: _fl.description,
                      ),
                    );
                    scaffoldMessage(context, state.order.name);
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

  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Updated order $text success")));
  }

}

class FieldLink {
  String name = '';
  String description = '';
}
