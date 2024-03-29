import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReturnHome extends StatelessWidget {
  const ReturnHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {

        // Navigator.of(context).pop();
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

        BlocProvider.of<OrderBloc>(context).add(OrderLoadingEvent());
      },
      icon: const Icon(Icons.home),
    );
  }
}
