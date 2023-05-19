import 'package:calc_app/ui/bloc/material_bloc/material_bloc.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/screens/add_new_material_screen.dart';
import 'package:calc_app/ui/screens/add_new_order_screen.dart';
import 'package:calc_app/ui/screens/catalog_material_screen.dart';
import 'package:calc_app/ui/screens/login_screen.dart';
import 'package:calc_app/ui/widgets/list_view_order_widget.dart';
import 'package:flutter/material.dart';
import 'package:calc_app/constant/ui_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CatalogOrdersScreen extends StatelessWidget {
  const CatalogOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: elevationView,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.appTitle),
        // final text = AppLocalizations.of(context);
        // title: Text(text!.appTitle),
        actions: [
          // ///add material
          // IconButton(
          //   onPressed: () {
          //     // BlocProvider.of<MaterialBloc>(context).add(MaterialCreatingEvent());
          //     context.read<MaterialBloc>().add(MaterialCreatingEvent());
          //     Navigator.of(context).pushNamed(AddNewMaterialScreen.routeName);
          //   },
          //   icon: const Icon(Icons.medical_information_outlined),
          // ),
          ///Update list presentation orders
          IconButton(
            onPressed: () {
              //delete this or add any logic update
              context.read<OrderBloc>().add(OrderLoadingEvent());
              // BlocProvider.of<OrderBloc>(context).add(OrderLoadingEvent());
            },
            icon: const Icon(Icons.update),
          ),

          ///add order
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddNewOrderScreen.routeName);
            },
          ),
        ],
      ),
      body: const ListViewOrderWidget(),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(child: Text('Menu')),
              decoration: BoxDecoration(color: Colors.lightGreen),
            ),

            ///Menu material
            TextButton(
              child: const Text(
                'Menu Materials',
              ),
              onPressed: () {
                // context.read<MaterialBloc>().add(MaterialLoadingEvent());
                Navigator.of(context)
                    .pushNamed(CatalogMaterialScreen.routeName);
              },
            ),

            ///Login account
            TextButton(
              child: const Text('Account'),
              onPressed: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
            ),
            // ///add material
            // IconButton(
            //   onPressed: () {
            //     // BlocProvider.of<MaterialBloc>(context).add(MaterialCreatingEvent());
            //     context.read<MaterialBloc>().add(MaterialCreatingEvent());
            //     Navigator.of(context).pushNamed(AddNewMaterialScreen.routeName);
            //   },
            //   icon: const Icon(Icons.medical_information_outlined),
            // ),
          ],
        ),
      ),
    );
  }
}
