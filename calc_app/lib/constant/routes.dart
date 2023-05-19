import 'package:calc_app/data/models/order_model.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/screens/add_new_material_screen.dart';
import 'package:calc_app/ui/screens/catalog_material_screen.dart';
import 'package:calc_app/ui/screens/component_field_screen.dart';
import 'package:calc_app/ui/screens/add_new_order_screen.dart';
import 'package:calc_app/ui/screens/edit_order_screen.dart';
import 'package:calc_app/ui/screens/login_screen.dart';
import 'package:calc_app/ui/screens/view_order_screen_with_component.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/screens/catalog_orders_screen.dart';

// import '../ui/screens/settings_deliver_screen.dart';
// import '../ui/screens/nomenclature_deliver.dart';

final routes = {
  '/': (ctx) {
    BlocProvider.of<OrderBloc>(ctx).add(OrderLoadingEvent());
    return const CatalogOrdersScreen();
  },
  AddNewOrderScreen.routeName: (ctx) => const AddNewOrderScreen(),
  ViewOrderScreenWithListComponent.routeName: (ctx) =>
      const ViewOrderScreenWithListComponent(),
  EditOrderScreen.routeName: (ctx) => const EditOrderScreen(),
  ComponentFieldScreen.routeName: (ctx) => const ComponentFieldScreen(),
  AddNewMaterialScreen.routeName: (ctx) => const AddNewMaterialScreen(),
  CatalogMaterialScreen.routeName: (ctx) {
    BlocProvider.of<MaterialBloc>(ctx).add(MaterialLoadingEvent());
    return const CatalogMaterialScreen();
  },
  LoginScreen.routeName: (ctx) {
    // BlocProvider.of<LoginBloc>(ctx).add(LoginEvent());
    return const LoginScreen();

  }
};
