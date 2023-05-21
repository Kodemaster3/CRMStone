import 'package:calc_app/data/models/material_model.dart';
import 'package:calc_app/domain/entities/material.dart';

class MaterialMapper {

  MaterialModel getModelFromEntity(MaterialEntity materialEntity) {
    return MaterialModel(
      id: materialEntity.id,
      name: materialEntity.name,
      weightPerCubMeter: materialEntity.weightPerCubMeter,
      pricePerCubMeter: materialEntity.pricePerCubMeter,
    );
  }
}
