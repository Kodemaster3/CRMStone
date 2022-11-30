import 'dart:developer' as dev;

import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewOrderScreen extends StatelessWidget {
  static const routeName = '/AddNewOrderScreen';

  AddNewOrderScreen({Key? key}) : super(key: key);

  final _fl = FieldLink();

  @override
  Widget build(BuildContext context) {
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
                onChanged: (value) => _fl.name = value,
                onFieldSubmitted: (_) {
                  //TODO: need drop addEvent and Navigation or implement
                  //regulations because. If submit without description,
                  //repository saved '' description.
                  BlocProvider.of<OrderBloc>(context).add(OrderCreateEvent(
                      name: _fl.name, description: _fl.description));
                  scaffoldMessage(context, _fl.name);
                  Navigator.of(context).pop();
                },
                decoration: const InputDecoration(
                  hintText: 'Write name order',
                ),
              ),

              ///Field description in order
              TextFormField(
                maxLines: 3,
                onChanged: (value) => _fl.description = value,
                onFieldSubmitted: (_) {
                  BlocProvider.of<OrderBloc>(context).add(OrderCreateEvent(
                      name: _fl.name, description: _fl.description));
                  scaffoldMessage(context, _fl.name);
                  Navigator.of(context).pop();
                },
                decoration: const InputDecoration(
                  hintText: 'Write name order',
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_box),
                onPressed: () {
                  BlocProvider.of<OrderBloc>(context).add(OrderCreateEvent(
                      name: _fl.name, description: _fl.description));
                  scaffoldMessage(context, _fl.name);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("added order $text success")));
  }
}

class FieldLink {
  String name = '';
  String description = '';
}
