// import 'package:calc_app/domain/entities/order.dart';
// import 'package:flutter/material.dart';
// //import 'package:intl/intl.dart';

// class ReportDeliverScreen extends StatelessWidget {
//   final OrderEntity deliver;
//   const ReportDeliverScreen({Key? key, required this.deliver})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(deliver.nameDeliver),
//       ),
//       body: Column(
//         children: <Widget>[
//           //   Text(
//           //     'createDeliverDate ${DateFormat("dd.MM.yy HH:mm:ss", Localizations.localeOf(context).languageCode).format(deliver.createDeliverDate)}',
//           //   ),
//           //   deliver.editTime == null
//           //       ? Container()
//           //       : Text(
//           //           'editTime ${DateFormat("dd.MM.yy HH:mm:ss", Localizations.localeOf(context).languageCode).format(deliver.editTime!)}',
//           //         ),
//           SizedBox(
//             height: 600,
//             child: ListView.builder(
//                 itemCount: deliver.component.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Column(
//                     children: <Widget>[
//                       Text('name ditail:  ${deliver.component[index].name}'),
//                       Text('material: ${deliver.component[index].material}'),
//                       Text(
//                           'width: ${deliver.component[index].width.toString()}'),
//                       Text(
//                           'length: ${deliver.component[index].length.toString()}'),
//                       Text(
//                           'height: ${deliver.component[index].height.toString()}'),
//                       Text(
//                           'quantity: ${deliver.component[index].quantity.toString()}'),
//                       Text(
//                           'qubature: ${qubature(deliver.component[index].quantity, deliver.component[index].width, deliver.component[index].length, deliver.component[index].height)} m3'),
//                       Text(
//                           'quadrature: ${quadrature(deliver.component[index].quantity, deliver.component[index].width, deliver.component[index].length)} m2'),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   );
//                 }),
//           )
//         ],
//       ),
//     );
//   }

//   String qubature(int quantity, double width, double length, double height) {
//     return ((width * length * height) / 1000000 * quantity).toString();
//   }

//   String quadrature(int quantity, double width, double length) {
//     return ((width * length) / 10000 * quantity).toString();
//   }
// }
