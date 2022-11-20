import 'dart:developer' as dev;

import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewOrderScreen extends StatelessWidget {
  static const routeName = '/AddNewOrderScreen';
  const AddNewOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = '';
    String description = '';
    final bloc = BlocProvider.of<OrderBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(routeName),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return Column(
            children: [
              ///Field name in order
              TextFormField(
                onChanged: (value) => name = value,
                onFieldSubmitted: (_) {
                  //TODO: need drop addEvent and Navigation or implement
                  //regulations because. If submit without description,
                  //repository saved '' description.
                  addEvent(bloc, name, description);
                  scaffoldMessage(context, name);
                  Navigator.of(context).pop();
                },
                decoration: const InputDecoration(
                  hintText: 'Write name order',
                ),
              ),

              ///Field description in order
              TextFormField(
                maxLines: 3,
                onChanged: (value) => description = value,
                onFieldSubmitted: (_) {
                  addEvent(bloc, name, description);
                  scaffoldMessage(context, name);
                  Navigator.of(context).pop();
                },
                decoration: const InputDecoration(
                  hintText: 'Write name order',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_box),
                onPressed: () {
                  addEvent(bloc, name, description);
                  scaffoldMessage(context, name);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void addEvent(OrderBloc bloc, String name, String description) {
    bloc.add(OrderCreateEvent(name: name, description: description));
  }

  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("added order $text success")));
  }
}
