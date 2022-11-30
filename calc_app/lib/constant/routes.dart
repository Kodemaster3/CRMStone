import 'package:calc_app/ui/screens/component_field_screen.dart';
import 'package:calc_app/ui/screens/add_new_order_screen.dart';
import 'package:calc_app/ui/screens/edit_order_screen.dart';
import 'package:calc_app/ui/screens/view_order_screen_with_component.dart';

import '../ui/screens/catalog_orders_screen.dart';
// import '../ui/screens/settings_deliver_screen.dart';
// import '../ui/screens/nomenclature_deliver.dart';

final routes = {
  '/': (ctx) => const CatalogOrdersScreen(),
  AddNewOrderScreen.routeName: (ctx) => AddNewOrderScreen(),
  ViewOrderScreenWithListComponent.routeName: (ctx) =>
      const ViewOrderScreenWithListComponent(),
  EditOrderScreen.routeName: (ctx) => EditOrderScreen(),
  ComponentFieldScreen.routeName: (ctx) => ComponentFieldScreen(),
  // NomenclatureDeliverScreen.routeName: (ctx) => NomenclatureDeliverScreen(),
};
