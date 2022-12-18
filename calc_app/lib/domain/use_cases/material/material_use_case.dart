import 'dart:math';

import 'package:calc_app/domain/entities/material.dart';
import 'package:calc_app/domain/repository/material_local/material_repository.dart';

class CreateMaterialUseCase {
  final MaterialRepository materialRepository;

  const CreateMaterialUseCase(
    this.materialRepository,
  );

  Future<bool> call({
    required String name,
    required double weightPerCubMeter,
    required double pricePerCubMeter,
  }) async {
    // final containersEntity = await materialRepository.getAllMaterial();
    final containersId =
        (await materialRepository.getAllMaterial()).map((e) => e.id);
    final tempNewId = newId();
    final materialEntity = MaterialEntity(
      id: containersId.contains(tempNewId) ? newId() : tempNewId,
      name: name,
      weightPerCubMeter: weightPerCubMeter,
      pricePerCubMeter: pricePerCubMeter,
    );
    return await materialRepository.createMaterial(materialEntity);
  }

  String newId() {
    String id = Random().nextInt(999999).toString();
    final now = DateTime.now().microsecondsSinceEpoch.toString();
    while (id.length < 10) {
      id = '0$id';
    }
    return '$now$id';
  }
}

class UpdateMaterialUseCase {
  final MaterialRepository materialRepository;

  const UpdateMaterialUseCase(this.materialRepository);

  Future<bool> call({
    required String idMaterial,
    required String name,
    required double weightPerCubMeter,
    required double pricePerCubMeter,
  }) async {
    final materialEntity = MaterialEntity(
        id: idMaterial,
        name: name,
        weightPerCubMeter: weightPerCubMeter,
        pricePerCubMeter: pricePerCubMeter);
    return await materialRepository.updateMaterialById(materialEntity);
  }
}

class GetAllMaterialUseCase {
  final MaterialRepository materialRepository;

  const GetAllMaterialUseCase(this.materialRepository);

  Future<List<MaterialEntity>> call() async {
    return await materialRepository.getAllMaterial();
  }
}

class GetMaterialByIdUseCase {
  final MaterialRepository materialRepository;

  const GetMaterialByIdUseCase(this.materialRepository);

  Future<MaterialEntity> call({required String idMaterial}) async {
    return await materialRepository.getMaterialById(idMaterial: idMaterial);
  }
}

class DeleteMaterialUseCase {
  final MaterialRepository materialRepository;

  const DeleteMaterialUseCase(this.materialRepository);

  Future<bool> call({required String idMaterial}) async {
    return await materialRepository.deleteMaterialById(idMaterial: idMaterial);
  }
}
