import 'dart:developer' as dev;

import 'package:calc_app/domain/use_cases/material/material_use_case.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_event.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialBloc extends Bloc<MaterialEvent, MaterialState> {
  final CreateMaterialUseCase createMaterialUseCase;
  final UpdateMaterialUseCase updateMaterialUseCase;
  final GetAllMaterialUseCase getAllMaterialUseCase;
  final GetMaterialByIdUseCase getMaterialByIdUseCase;
  final DeleteMaterialUseCase deleteMaterialUseCase;

  MaterialBloc({
    required this.createMaterialUseCase,
    required this.updateMaterialUseCase,
    required this.getAllMaterialUseCase,
    required this.getMaterialByIdUseCase,
    required this.deleteMaterialUseCase,
  }) : super(MaterialInitialState()) {
    /// Emit all orders
    on<MaterialLoadingEvent>((event, emit) async {
      emit(MaterialLoadingState());
      final materialList = await getAllMaterialUseCase();
      emit(MaterialLoadedState(materialList: materialList));
    });

    /// Create new material
    on<MaterialCreateEvent>((event, emit) async {
      final response = await createMaterialUseCase.call(
          name: event.name,
          weightPerCubMeter: event.weightPerCubMeter,
          pricePerCubMeter: event.pricePerCubMeter);
      if (response) {
        emit(MaterialMessageByState(
            message: 'Material ${event.name} is created success'));
      }
    });

    /// View one material uses in finish component
    on<MaterialViewByIdEvent>((event, emit) async {
      emit(MaterialLoadingState());
      final material =
          await getMaterialByIdUseCase(idMaterial: event.idMaterial);
      emit(MaterialPresentationByIdState(materialEntity: material));
    });

    /// Update material
    on<MaterialUpdateEvent>((event, emit) async {
      emit(MaterialLoadingState());
      final response = await updateMaterialUseCase(
          idMaterial: event.idMaterial,
          name: event.name,
          weightPerCubMeter: event.weightPerCubMeter,
          pricePerCubMeter: event.pricePerCubMeter);
      if (response) {
        emit(MaterialMessageByState(
            message: 'Material ${event.name} is updated success'));
      }
    });

    ///Remove material from all place
    on<MaterialDeleteEvent>((event, emit) async {
      emit(MaterialLoadingState());
      final response = await deleteMaterialUseCase(idMaterial: event.idMaterial);
      if (response) {
        emit(const MaterialMessageByState(
            message: 'Material is removed success'));
      }
    });
  }
}
