// import 'package:calc_app/main.dart';
// import 'package:calc_app/ui/screens/report_deliver_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import '../../domain/entities/order.dart';
// import '../../delete/db_local/db.dart';

// class ViewCatalog extends StatefulWidget {
//   const ViewCatalog({Key? key}) : super(key: key);

//   @override
//   _ViewCatalogState createState() => _ViewCatalogState();
// }

// class _ViewCatalogState extends State<ViewCatalog> {
//   List<OrderEntity> delivers = [];

//   @override
//   void initState() {
//     _loadListDeliver();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final textLocalization = AppLocalizations.of(context);
//     return delivers.isEmpty
//         ? Center(
//             child: Text(textLocalization!.add_new_deliver),
//           )
//         : ListView.builder(
//             padding: const EdgeInsets.all(10),
//             itemCount: delivers.length,
//             itemBuilder: (BuildContext context, int index) {
//               return GestureDetector(
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ReportDeliverScreen(
//                       deliver: delivers[index],
//                     ),
//                   ),
//                 ),
//                 child: Container(
//                   height: 60,
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     border: Border.all(color: Colors.white),
//                     gradient: _linearGradient(index),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text('${index + 1}'),
//                       const SizedBox(
//                         width: 15,
//                       ),
//                       Text(delivers[index].id),
//                       const SizedBox(
//                         width: 15,
//                       ),
//                       Text(
//                           '${textLocalization!.have_position} ${delivers[index].component.length}'),
//                       IconButton(
//                         onPressed: () {
//                           deleteDeliver(delivers[index]);
//                         },
//                         icon: const Icon(Icons.delete),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             });
//   }

//   LinearGradient _linearGradient(int index) {
//     return LinearGradient(
//       begin: index % 2 == 0
//           ? const Alignment(1.0, 0.0)
//           : const Alignment(-1.0, 0.0),
//       end: index % 2 != 0
//           ? const Alignment(1.0, 0.0)
//           : const Alignment(-1.0, 0.0),
//       colors: const <Color>[Colors.amberAccent, Colors.grey],
//     );
//   }

//   void _loadListDeliver() async {
//     await App.init();
//     List<OrderEntity> newDelivers = [];
//     final listDeliversInJson = Db.localPref.getStringList('delivers');
//     if (listDeliversInJson == null) {
//       return;
//     }
//     for (var e in listDeliversInJson) {
//       final deliver = OrderEntity.fromJson(e);
//       newDelivers.add(deliver);
//     }

//     setState(() {
//       delivers = newDelivers;
//     });
//   }

//   void deleteDeliver(OrderEntity deliv) {
//     delivers.remove(deliv);

//     Db().pushAllDeliversInDb(delivers);
//     setState(() {});
//   }
// }
