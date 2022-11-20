import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReturnHome extends StatelessWidget {
  const ReturnHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<OrderBloc>(context);
    return IconButton(
      onPressed: () {
        bloc.add(OrderLoadingEvent());
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.home),
    );
  }
}
