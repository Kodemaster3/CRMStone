import 'package:calc_app/ui/screens/add_new_order_screen.dart';
import 'package:calc_app/ui/screens/edit_order_screen.dart';
import 'package:calc_app/ui/screens/view_order_screen_with_component.dart';

import '../ui/screens/catalog_deliver_screen.dart';
// import '../ui/screens/settings_deliver_screen.dart';
// import '../ui/screens/nomenclature_deliver.dart';

final routes = {
  '/': (ctx) => const CatalogDeliverScreen(),
  AddNewOrderScreen.routeName: (ctx) => const AddNewOrderScreen(),
  ViewOrderScreenWithListComponent.routeName: (ctx) =>
      const ViewOrderScreenWithListComponent(),
  EditOrderScreen.routeName: (ctx) => const EditOrderScreen(),
  // NomenclatureDeliverScreen.routeName: (ctx) => NomenclatureDeliverScreen(),
};
