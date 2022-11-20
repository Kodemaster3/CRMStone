// import 'package:calc_app/delete/db_local/db.dart';
// import 'package:calc_app/ui/screens/nomenclature_deliver.dart';

// import '../../domain/entities/order.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class SettingsDeliverScreen extends StatelessWidget {
//   static const routeName = '/Settings-Deliver';
//   SettingsDeliverScreen({Key? key}) : super(key: key);

//   late final List<OrderEntity> delivers;
//   final _nameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     Db().delivers.then((value) => delivers = value);
//     final textLocalate = AppLocalizations.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(textLocalate!.nomenclature_deliver),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(Icons.home))
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             child: TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 fillColor: Colors.brown,
//                 labelText: textLocalate.name_deliver,
//                 labelStyle: const TextStyle(fontSize: 20),
//                 prefixIcon: const Icon(
//                   Icons.account_tree,
//                   color: Colors.deepOrange,
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   borderSide: BorderSide(color: Colors.black26, width: 1),
//                 ),
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (checkingNameDeliver()) {
//                 final snackBar = SnackBar(
//                   content: Text(
//                     textLocalate.its_old_deliver_you_,
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   action: SnackBarAction(
//                     label: textLocalate.yes,
//                     onPressed: () {
//                       Navigator.of(context).pushNamed(
//                           NomenclatureDeliverScreen.routeName,
//                           arguments: <String, dynamic>{
//                             'name': _nameController.text,
//                             'list': delivers
//                           });
//                     },
//                   ),
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
//               } else {
//                 delivers.add(OrderEntity(
//                   id: _nameController.text,
//                   component: [],
//                 ));
//                 Db().pushAllDeliversInDb(delivers);
//                 Navigator.of(context).pushNamed(
//                     NomenclatureDeliverScreen.routeName,
//                     arguments: <String, dynamic>{
//                       'name': _nameController.text,
//                       'list': delivers
//                     });
//               }
//             },
//             child: const Icon(
//               Icons.check_sharp,
//               color: Colors.red,
//             ),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.grey[300],
//               elevation: 3,
//               alignment: const Alignment(3, 0),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   bool checkingNameDeliver() {
//     for (var e in delivers) {
//       if (e.nameDeliver == _nameController.text) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
