import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';

class AddNewComponentScreen extends StatelessWidget {
  const AddNewComponentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log('be in add new component screen');
    return TextButton(
        child: const Text('Add Comp'),
        onPressed: () {
          BlocProvider.of<OrderBloc>(context).add(ComponentOrderCreateEvent(
              name: 'as',
              material: 'as',
              height: 0,
              length: 0,
              quantity: 0,
              weightPerCubMeter: 0,
              width: 0,
              pricePerCubMeter: 0));
        });
  }
}
