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
