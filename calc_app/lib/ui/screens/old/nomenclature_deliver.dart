// import 'package:calc_app/delete/db_local/db.dart';
// import 'package:calc_app/domain/entities/component.dart';
// import 'package:calc_app/ui/widgets/view_nomenclature_widget.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// // import 'package:calc_app/db_local/db.dart';
// import 'package:calc_app/domain/entities/order.dart';
//
// class NomenclatureDeliverScreen extends StatelessWidget {
//   static const routeName = '/Nomenclature-Deliver';
//   NomenclatureDeliverScreen({Key? key}) : super(key: key);
//
//   late final String nameDeliver;
//   late final List<OrderEntity> delivers;
//   late final ComponentEntity nomenclature;
//
//   final _fieldNameNomenclature = TextEditingController();
//   final _fieldMaterial = TextEditingController();
//   final _fieldWidth = TextEditingController();
//   final _fieldLength = TextEditingController();
//   final _fieldHeight = TextEditingController();
//   final _fieldWeightPerCubMeter = TextEditingController();
//   final _fieldQuantity = TextEditingController();
//   final _fieldPricePerCubMeter = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final textLocalization = AppLocalizations.of(context);
//     nameDeliver = (ModalRoute.of(context)!.settings.arguments as Map)['name'];
//     delivers = (ModalRoute.of(context)!.settings.arguments as Map)['list'];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(nameDeliver),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.of(context).pushReplacementNamed('/');
//             },
//             icon: const Icon(Icons.home),
//           ),
//           IconButton(
//               onPressed: () {
//                 saveField();
//               },
//               icon: const Icon(Icons.add)),
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(10),
//         child: ListView(
//           children: <Widget>[
//             fieldNameNomenclature(textLocalization!.name_nomenclature),
//             sizeBox(),
//             fieldNameMaterial(textLocalization.name_material),
//             sizeBox(),
//             fieldWidth(textLocalization.width),
//             sizeBox(),
//             fieldLength(textLocalization.length),
//             sizeBox(),
//             fieldHeight(textLocalization.height),
//             sizeBox(),
//             fieldWeightPerCubMeter(textLocalization.weight_per_cub_meter),
//             sizeBox(),
//             fieldQuantity(textLocalization.quantity),
//             sizeBox(),
//             fieldPricePerCubMeter(textLocalization.price_per_cub_meter),
//             sizeBox(),
//             ViewNomenclatureDelivers(
//               delivers: delivers,
//               nameDeliver: nameDeliver,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   OrderEntity getDeliverFromList() {
//     for (var e in delivers) {
//       if (e.nameDeliver == nameDeliver) {
//         return e;
//       }
//     }
//     return OrderEntity(
//       id: nameDeliver,
//       component: [], /*editTime: DateTime.now()*/
//     );
//   }
//
//   Widget fieldNameNomenclature(String text) {
//     return TextFormField(
//       controller: _fieldNameNomenclature,
//       decoration: InputDecoration(labelText: text),
//     );
//   }
//
//   Widget fieldNameMaterial(String text) {
//     return TextFormField(
//       controller: _fieldMaterial,
//       decoration: InputDecoration(labelText: text),
//     );
//   }
//
//   Widget fieldWidth(String text) {
//     return TextFormField(
//       controller: _fieldWidth,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(labelText: text),
//     );
//   }
//
//   Widget fieldLength(String text) {
//     return TextFormField(
//       controller: _fieldLength,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(labelText: text),
//     );
//   }
//
//   Widget fieldHeight(String text) {
//     return TextFormField(
//       controller: _fieldHeight,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(labelText: text),
//     );
//   }
//
//   Widget fieldWeightPerCubMeter(String text) {
//     return TextFormField(
//       controller: _fieldWeightPerCubMeter,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(labelText: text),
//     );
//   }
//
//   Widget fieldQuantity(String text) {
//     return TextFormField(
//       controller: _fieldQuantity,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(labelText: text),
//     );
//   }
//
//   Widget fieldPricePerCubMeter(String text) {
//     return TextFormField(
//       controller: _fieldPricePerCubMeter,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(labelText: text),
//     );
//   }
//
//   void saveField() {
//     nomenclature = ComponentEntity(
//         name: _fieldNameNomenclature.text,
//         material: _fieldMaterial.text,
//         height: double.parse(_fieldHeight.text),
//         length: double.parse(_fieldLength.text),
//         quantity: int.parse(_fieldQuantity.text),
//         weightPerCubMeter: double.parse(_fieldPricePerCubMeter.text),
//         width: double.parse(_fieldWidth.text),
//         pricePerCubMeter: double.parse(_fieldPricePerCubMeter.text));
//
//     for (var i = 0; i < delivers.length; i++) {
//       if (delivers[i].id == nameDeliver) {
//         delivers[i].component.add(nomenclature);
//         // delivers[i].editTime = DateTime.now();
//         break;
//       }
//     }
//     Db().pushAllDeliversInDb(delivers);
//   }
//
//   Widget sizeBox() {
//     return const SizedBox(
//       width: 5,
//     );
//   }
// }
