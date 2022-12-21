import 'package:calc_app/domain/entities/material.dart';

abstract class MaterialState {
  const MaterialState();
}

class MaterialInitialState extends MaterialState {}

class MaterialLoadingState extends MaterialState {}

class MaterialLoadedState extends MaterialState {
  final List<MaterialEntity> materialList;
  const MaterialLoadedState({
    required this.materialList,
  });
}

class MaterialStartFieldsState extends MaterialState {
  final String emptyFieldId;
  final String emptyFieldName;
  final double emptyFieldWeightPerCubMeter;
  final double emptyFieldPricePerCubMeter;

  const MaterialStartFieldsState({
    required this.emptyFieldId,
    required this.emptyFieldName,
    required this.emptyFieldWeightPerCubMeter,
    required this.emptyFieldPricePerCubMeter,
  });
}

class MaterialUpdatingFieldsState extends MaterialState {
  final String idMaterial;
  final String oldFieldName;
  final double oldFieldWeightPerCubMeter;
  final double oldFieldPricePerCubMeter;

  const MaterialUpdatingFieldsState({
    required this.idMaterial,
    required this.oldFieldName,
    required this.oldFieldWeightPerCubMeter,
    required this.oldFieldPricePerCubMeter,
  });
}

class MaterialPresentationByIdState extends MaterialState {
  final MaterialEntity materialEntity;
  const MaterialPresentationByIdState({
    required this.materialEntity,
  });
}

class MaterialMessageByState extends MaterialState {
  final String message;

  const MaterialMessageByState({
    required this.message,
  });
}

class MaterialSetIdState extends MaterialState{
  final MaterialEntity materialEntity;
  final List<MaterialEntity> materialList;

  const MaterialSetIdState({
    required this.materialEntity,
    required this.materialList,
  });
}
