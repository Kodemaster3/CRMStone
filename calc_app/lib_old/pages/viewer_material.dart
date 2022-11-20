// import 'dart:convert';

// import 'package:calc_app/model/material_stone.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ViewerMaterial extends StatefulWidget {
//   const ViewerMaterial({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _ViewerMaterialState();
// }

// class _ViewerMaterialState extends State<ViewerMaterial> {
//   // MaterialStone material;

//   @override
//   void initState() {
//     super.initState();
//     _loadMatPref();
//   }

//   _loadMatPref() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String line;
//     setState(() {
//       final line1 =
//           preferences.getString('KMat') ?? '{name: fuck, priceS: 0, priceC: 0}';
//       line = line1;
//       print('lock here $line');
//       Map<String, dynamic> matMap = jsonDecode(line);
//       MaterialStone material = MaterialStone.fromJson(matMap);
//       print(material.name);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Перечень материала'),
//         centerTitle: true,
//       ),
//       body: Card(
//         margin: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             ListTile(
//               title: Text('material' /* .name*/),

//               // subtitle: Text(material.priceS),
//               // trailing: Text(material.priceC),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
