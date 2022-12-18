import 'dart:developer' as dev;

import 'package:calc_app/data/datasource/material_local_data_source.dart';
import 'package:calc_app/data/models/material_model.dart';
import 'package:calc_app/data/repository/material_mapper.dart';
import 'package:calc_app/domain/entities/material.dart';
import 'package:calc_app/domain/repository/material_local/material_repository.dart';

const topPositionInList = 0;

class MaterialRepositoryImpl implements MaterialRepository {
  final MaterialLocalDataSource localDataSource;
  final MaterialMapper materialMapper;

  const MaterialRepositoryImpl({
    required this.localDataSource,
    required this.materialMapper,
  });

  @override
  Future<bool> createMaterial(MaterialEntity materialEntity) async {
    try {
      final List<MaterialModel> dataList =
          await localDataSource.getLastMaterialListFromCache();
      final List<String> oldId = dataList.map((e) => e.id).toList();
      if (oldId.contains(materialEntity.id)) {
        throw Exception('id is not unique');
      }
      dataList.insert(
          topPositionInList, materialMapper.getModelFromEntity(materialEntity));
      localDataSource.materialToCache(dataList);
      dev.log(
          'Created material name: ${materialEntity.name},'
          ' id: ${materialEntity.id},'
          ' lengthMaterialDB: ${dataList.length}',
          name: 'DB(repository)');
      return true;
    } on Exception {
      dev.log('Exc in material repository, method createMaterial()', name: 'repos');
      return false;
    }
  }

  @override
  Future<bool> deleteMaterialById({required String idMaterial}) async {
    try {
      final dataList = await localDataSource.getLastMaterialListFromCache();
      for (var element in dataList) {
        if (element.id == idMaterial) {
          dataList.remove(element);
          await localDataSource.materialToCache(dataList);
          break;
        }
      }
      return true;
    } on Exception {
      dev.log('Exc in material repository, method deleteMaterialById()', name: 'repos');
      return false;
    }
  }

  @override
  Future<List<MaterialEntity>> getAllMaterial() async {
    try {
      final dataList = await localDataSource.getLastMaterialListFromCache();
      return dataList;
    } on Exception {
      dev.log('Exc in material repository, method getAllMaterials()', name: 'repos');
    }
    throw Exception('Exception in repository lvl data');
  }

  @override
  Future<MaterialEntity> getMaterialById({required String idMaterial}) async {
    try {
      final dataList = await localDataSource.getLastMaterialListFromCache();
      for (var element in dataList) {
        if (element.id == idMaterial) {
          return element;
        }
      }
    } on Exception {
      dev.log('Exc in material repository, method getAllMaterials()', name: 'repos');
    }
    throw Exception('Exception in repository lvl data');
  }

  @override
  Future<bool> updateMaterialById(MaterialEntity materialEntity) async {
    try {
      final dataList = await localDataSource.getLastMaterialListFromCache();
      for (var element in dataList) {
        if (element.id == materialEntity.id) {
          final updateMaterial = element.copyWith(
            name: materialEntity.name,
            weightPerCubMeter: materialEntity.weightPerCubMeter,
            pricePerCubMeter: materialEntity.pricePerCubMeter,
          );
          dataList.remove(element);
          dataList.insert(topPositionInList, updateMaterial);
          await localDataSource.materialToCache(dataList);
          return true;
        }
      }
      return false;
    } on Exception {
      dev.log('Exc in material repository, method getAllMaterials()', name: 'repos');
      return false;
    }
  }
}
