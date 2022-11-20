
// import 'dart:convert';

// import 'package:calc_app/model/material_stone.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefMaterial extends ChangeNotifier {
//   late SharedPreferences _sharedPreferences;
//   late MaterialStone mat;

//   void loadMatPref() {
//     final line = _sharedPreferences.getString('KMat') ??
//         '{name: fuck, priceS: 0, priceC: 0}';
//     print('lock here $line');

//     Map<String, dynamic> matMap = jsonDecode(line);

//     mat = MaterialStone.fromJson(matMap);
//     print(mat.name);
//   }

//   Future<void> setMaterialPref(MaterialStone newMaterial) async {
//     await _sharedPreferences.setString('KMat', jsonEncode(newMaterial));
//   }

//   // Future<void> _setMaterialPref(String mat) async {
//   // //   await this._prefs.setString('KMat', mat);
//   // //   print('_pref is saved');
//   // // }
// }
