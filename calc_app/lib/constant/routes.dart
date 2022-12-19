import 'package:calc_app/ui/screens/add_new_material_screen.dart';
import 'package:calc_app/ui/screens/component_field_screen.dart';
import 'package:calc_app/ui/screens/add_new_order_screen.dart';
import 'package:calc_app/ui/screens/edit_order_screen.dart';
import 'package:calc_app/ui/screens/view_order_screen_with_component.dart';

import '../ui/screens/catalog_orders_screen.dart';
// import '../ui/screens/settings_deliver_screen.dart';
// import '../ui/screens/nomenclature_deliver.dart';

final routes = {
  '/': (ctx) => const CatalogOrdersScreen(),
  AddNewOrderScreen.routeName: (ctx) => const AddNewOrderScreen(),
  ViewOrderScreenWithListComponent.routeName: (ctx) =>
      const ViewOrderScreenWithListComponent(),
  EditOrderScreen.routeName: (ctx) => const EditOrderScreen(),
  ComponentFieldScreen.routeName: (ctx) => const ComponentFieldScreen(),
  AddNewMaterialScreen.routeName: (ctx) => const AddNewMaterialScreen(),
  // NomenclatureDeliverScreen.routeName: (ctx) => NomenclatureDeliverScreen(),
};
