// import 'package:calc_app/pages/material_page_set.dart';
// // import 'package:calc_app/pages/viewer_material.dart';
// import 'package:calc_app/pages/viewer_material_copy.dart';
// import 'package:flutter/material.dart';

// class MainPage extends StatelessWidget {
//   const MainPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Главная',
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         // mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) {
//                     return MaterialPageSet();
//                   }),
//                 );
//               },
//               child: const Text('Редактор материала')),
//           TextButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return ViewerMaterialCopy();
//                 }));
//               },
//               child: const Text('Отображение элементов'))
//         ],
//       ),
//     );
//   }
// }
