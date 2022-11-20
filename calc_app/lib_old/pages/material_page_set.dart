// import 'dart:convert';

// // import 'package:calc_app/db/shared_pref_material.dart';
// import 'package:calc_app/model/material_stone.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MaterialPageSet extends StatefulWidget {
//   const MaterialPageSet({Key? key}) : super(key: key);

//   @override
//   State<MaterialPageSet> createState() => _MaterialPageSet();
// }

// class _MaterialPageSet extends State<MaterialPageSet> {
//   final _formKey = GlobalKey<FormState>();

//   late SharedPreferences _prefs;
//   late MaterialStone newMaterial;

//   final _nameController = TextEditingController();
//   final _priceSquareMeterController = TextEditingController();
//   final _priceCubicMeterController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     SharedPreferences.getInstance()
//       ..then((prefs) {
//         setState(() => this._prefs = prefs);
//       });
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _priceSquareMeterController.dispose();
//     _priceCubicMeterController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // SharedPrefMaterial _state = Provider.of<SharedPrefMaterial>(context);
//     return
//         // MultiProvider(
//         // providers: [
//         // ChangeNotifierProvider<SharedPrefMaterial>.value(
//         // value: SharedPrefMaterial()),
//         // ],
//         // child:
//         Scaffold(
//       appBar: AppBar(
//         title: const Text('Имя и стоимость материала'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             /* Name field */
//             TextFormField(
//               controller: _nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Название камня',
//                 labelStyle: TextStyle(fontSize: 20),
//                 hintText: 'Название камня или сокращенное имя',
//                 prefixIcon: Icon(Icons.add_to_photos),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   borderSide: BorderSide(color: Colors.black, width: 1),
//                 ),
//               ),
//               validator: _validateName,
//             ),
//             const SizedBox(
//               height: 15,
//             ),

//             /* Price m² */
//             TextFormField(
//               controller: _priceSquareMeterController,
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 FilteringTextInputFormatter(RegExp(r'^\d*[.]?\d*$'),
//                     allow: true),
//               ],
//               decoration: const InputDecoration(
//                 labelText: 'Цена м²',
//                 labelStyle: TextStyle(fontSize: 20),
//                 hintText: 'Стоимость 1 м.кв.',
//                 helperText: 'ХХХ.ХХ или Х.Х или .ХХ или XX',
//                 prefixIcon: Icon(Icons.price_change),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   borderSide: BorderSide(color: Colors.black, width: 1),
//                 ),
//               ),
//               validator: _validatePriceSq,
//             ),
//             const SizedBox(
//               height: 15,
//             ),

//             /* Price m³ */
//             TextFormField(
//               controller: _priceCubicMeterController,
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 FilteringTextInputFormatter(RegExp(r'^\d*[.]?\d*$'),
//                     allow: true),
//               ],
//               decoration: const InputDecoration(
//                 labelText: 'Цена м³',
//                 labelStyle: TextStyle(fontSize: 20),
//                 hintText: 'Стоимость 1 м.куб.',
//                 helperText: 'ХХХ.ХХ или Х.Х или .ХХ или XX',
//                 prefixIcon: Icon(Icons.price_change),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   borderSide: BorderSide(color: Colors.black, width: 1),
//                 ),
//               ),
//               validator: _validatePriceCub,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 if (_addForm()) {
//                   // _state.setMaterialPref(newMaterial);
//                 }
//               },
//               style: ElevatedButton.styleFrom(primary: Colors.green),
//               child: const Text('Добавить'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _loadMatPref();
//                 // _state.loadMatPref();
//               },
//               child: const Text('Просмотреть содержимое памяти'),
//             ),
//           ],
//         ),
//       ),
//       // )
//     );
//   }

//   String? _validateName(String? value) {
//     if (value!.isEmpty) {
//       return 'Пустое поле не допустимо';
//     } else if (value.length < 3) {
//       return 'Слишком короткое название';
//     } else {
//       return null;
//     }
//   }

//   String? _validatePriceSq(String? value) {
//     if (value!.isEmpty) {
//       _priceSquareMeterController.text = '0';
//     } else {
//       return null;
//     }
//   }

//   String? _validatePriceCub(String? value) {
//     if (value!.isEmpty) {
//       _priceCubicMeterController.text = '0';
//     } else {
//       return null;
//     }
//   }

//   bool _addForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       newMaterial = MaterialStone(
//           name: _nameController.text,
//           priceS: _priceSquareMeterController.text,
//           priceC: _priceCubicMeterController.text);
//       _setMaterialPref(newMaterial);

//       _nameController.clear();
//       _priceSquareMeterController.clear();
//       _priceCubicMeterController.clear();
//       return true;
//     } else {
//       print('Form is not valid');
//       return false;
//     }
//   }

// // /* отправлено в shared_pref_material
//   void savePref(String name, String priseSq, String priceCu) {
//     newMaterial = MaterialStone(name: name, priceS: priseSq, priceC: priceCu);
//     print(newMaterial.hashCode);
//   }

//   Future<void> _setMaterialPref(MaterialStone mat) async {
//     await this._prefs.setString('KMat', jsonEncode(mat));
//     print('_pref is saved');
//   }

//   void _loadMatPref() {
//     final line =
//         _prefs.getString('KMat') ?? '{name: fuck, priceS: 0, priceC: 0}';
//     print('lock here $line');
//     Map<String, dynamic> matMap = jsonDecode(line);

//     setState(() {
//       newMaterial = MaterialStone.fromJson(matMap);
//       print(newMaterial.name);
//     });
//   }
//   // */
// }
// //
// //
// //
// /** Необходимо добавить showDialog */

// //  Map<String, dynamic> userMap = jsonDecode(jsonString);
// // var user = User.fromJson(userMap);
// // print('Howdy, ${user.name}!');
// // print('We sent the verification link to ${user.email}.');

// // Пример декодирования
// // Map<String, dynamic> parsedMap = JSON.decode(json);
// // print(parsedMap['name']); // John
// // print(parsedMap['age']); // 30
// // Пример кодирования:

// // Map<String, dynamic> mapData = <String, dynamic>{ 'hello': 'world!' };
// // String jsonData = JSON.encode(mapData); // convert map to String
