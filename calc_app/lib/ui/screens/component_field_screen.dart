import 'dart:developer' as dev;

import 'package:calc_app/ui/widgets/component/new_component_field_widget.dart';
import 'package:calc_app/ui/widgets/component/update_component_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';

class ComponentFieldScreen extends StatelessWidget {
  static const routeName = '/ComponentFieldScreen';

  const ComponentFieldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dev.log('In add new component screen', name: 'ui');
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        /// state ComponentEditingField if old to fill field
        if (state is ComponentEditingField) {
          return Scaffold(
            body: UpdateComponentFieldWidget(),
          );
        }
        /// state OrderViewWithEmptyListComponent new
        return Scaffold(
          body: NewComponentFieldWidget(),
        );
      },
    );
  }
}
