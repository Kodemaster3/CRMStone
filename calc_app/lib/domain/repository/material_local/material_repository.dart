
import 'package:calc_app/domain/entities/material.dart';

abstract class MaterialRepository {
  Future<List<MaterialEntity>> getAllMaterial();

  Future<bool> createMaterial(MaterialEntity materialEntity);

  Future<bool> updateMaterialById(MaterialEntity materialEntity);

  Future<bool> deleteMaterialById({required String idMaterial});

  Future<MaterialEntity> getMaterialById({required String idMaterial});
}