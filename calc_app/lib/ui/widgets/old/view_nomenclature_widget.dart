// import 'package:calc_app/delete/db_local/db.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:calc_app/domain/entities/order.dart';
// import 'package:calc_app/domain/entities/component.dart';

// class ViewNomenclatureDelivers extends StatefulWidget {
//   final List<OrderEntity> delivers;
//   final String nameDeliver;

//   const ViewNomenclatureDelivers({
//     Key? key,
//     required this.delivers,
//     required this.nameDeliver,
//   }) : super(key: key);

//   @override
//   State<ViewNomenclatureDelivers> createState() =>
//       _ViewNomenclatureDeliversState();
// }

// class _ViewNomenclatureDeliversState extends State<ViewNomenclatureDelivers> {
//   @override
//   Widget build(BuildContext context) {
//     final textLocalization = AppLocalizations.of(context);
//     final nameDeliver = widget.nameDeliver;
//     final delivers = widget.delivers;
//     // final deliver = getDeliverFromList(nameDeliver, delivers);
//     final nomenclature = getNomenclatureFromList(nameDeliver, delivers);

//     return SizedBox(
//       height: 500,
//       child: ListView.builder(
//           padding: const EdgeInsets.all(10),
//           itemCount: nomenclature.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                     '${textLocalization!.name_nomenclature}: ${nomenclature[index].name} '),
//                 Text(
//                     '${textLocalization.name_material}: ${nomenclature[index].material} '),
//                 Row(
//                   children: [
//                     Text(
//                         '${textLocalization.width}: ${nomenclature[index].width.toString()} '),
//                     Text(
//                         '${textLocalization.length}: ${nomenclature[index].length.toString()} '),
//                     Text(
//                         '${textLocalization.height}: ${nomenclature[index].height.toString()} '),
//                   ],
//                 ),
//                 // Text('CubMetrUsed: ${cubMetrUsed(nomenclature[index])} '),
//                 Row(
//                   children: <Widget>[
//                     Text(
//                         '${textLocalization.weight_per_cub_meter}: ${nomenclature[index].weightPerCubMeter.toString()} '),
//                     Text(
//                         '${textLocalization.price_per_cub_meter}: ${nomenclature[index].pricePerCubMeter.toString()} '),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                         '${textLocalization.quantity}: ${nomenclature[index].quantity.toString()} '),
//                     IconButton(
//                       onPressed: () {
//                         nomenclature.removeAt(index);
//                         setState(() {});
//                       },
//                       icon: const Icon(
//                         Icons.delete,
//                         color: Colors.brown,
//                       ),
//                     )
//                   ],
//                 ),
//                 (nomenclature.length - 1) != index
//                     ? const SizedBox(
//                         height: 10,
//                       )
//                     : Row(
//                         children: [
//                           IconButton(
//                               onPressed: () =>
//                                   saveNomenclatureInDeliver(delivers),
//                               icon: const Icon(
//                                 Icons.save,
//                                 color: Colors.lightGreen,
//                               )),
//                           IconButton(
//                               onPressed: () => setState(() {}),
//                               icon: Icon(
//                                 Icons.update,
//                                 color: Colors.yellow[800],
//                               )),
//                         ],
//                       ),
//               ],
//             );
//           }),
//     );
//   }

//   List<ComponentEntity> getNomenclatureFromList(
//       String name, List<OrderEntity> delivers) {
//     for (var deliver in delivers) {
//       if (deliver.nameDeliver == name) {
//         return deliver.component;
//       }
//     }
//     return [];
//   }

//   OrderEntity getDeliverFromList(String name, List<OrderEntity> delivers) {
//     for (var deliver in delivers) {
//       if (deliver.nameDeliver == name) {
//         return deliver;
//       }
//     }
//     return OrderEntity(
//       id: 'NoN',
//       component: [], /*editTime: DateTime.now()*/
//     );
//   }

//   // String cubMetrUsed(Nomenclature nomenclature) {
//   //   return (nomenclature.width * nomenclature.length * nomenclature.height)
//   //       .toString();
//   // }

//   void saveNomenclatureInDeliver(List<OrderEntity> delivers) {
//     Db().pushAllDeliversInDb(delivers);
//   }
// }
