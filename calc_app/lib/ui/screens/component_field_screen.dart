import 'dart:developer' as dev;

import 'package:calc_app/ui/widgets/component/component_fields_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';

class ComponentFieldScreen extends StatelessWidget {
  static const routeName = '/ComponentFieldScreen';

  const ComponentFieldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dev.log('In ComponentFieldScreen', name: 'ui');
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        /// state OrderViewWithEmptyListComponent new
        if (state is ComponentCreatingFieldsState) {
          return Scaffold(
            body: ComponentFieldsWidget(
              idOrder: state.idOrder,
              idComponent: state.idComponent,
              name: state.name,
              description: state.description,
              materialId: state.materialId,
              width: state.width,
              length: state.length,
              height: state.height,
              weight: state.weight,
              quantity: state.quantity,
              unitLinear: state.unitsLinear,
              unitWeight: state.unitsWeight,
            ),
          );
        }

        /// state ComponentEditingField if old to fill field
        if (state is ComponentUpdatingFieldState) {
          return Scaffold(
            body: ComponentFieldsWidget(
              idOrder: state.idOrder,
              idComponent: state.idComponent,
              name: state.name,
              description: state.description,
              materialId: state.materialId,
              width: state.width,
              length: state.length,
              height: state.height,
              weight: state.weight,
              quantity: state.quantity,
              unitLinear: state.unitsLinear,
              unitWeight: state.unitsWeight,
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
