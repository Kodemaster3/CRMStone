import 'dart:convert';

import 'package:calc_app/data/models/material_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_MATERIAL_LIST = 'CACHED_MATERIAL_LIST';

abstract class MaterialLocalDataSource {
  Future<List<MaterialModel>> getLastMaterialListFromCache();

  Future<void> materialToCache(List<MaterialModel> materialModels);
}

class MaterialLocalDataSourceImpl extends MaterialLocalDataSource {
  final SharedPreferences sharedPreferences;

  MaterialLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<MaterialModel>> getLastMaterialListFromCache() {
    final jsonMaterialList =
        sharedPreferences.getStringList(CACHED_MATERIAL_LIST) ?? [];
    return Future.value(jsonMaterialList
        .map((material) => MaterialModel.fromJson(json.decode(material)))
        .toList());
  }

  @override
  Future<void> materialToCache(List<MaterialModel> materialModels) {
    final List<String> jsonMaterialList = materialModels
        .map((material) => json.encode(material.toJson()))
        .toList();

    sharedPreferences.setStringList(CACHED_MATERIAL_LIST, jsonMaterialList);
    return Future.value(jsonMaterialList);
  }
}
