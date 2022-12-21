import 'dart:developer' as dev;

import 'package:calc_app/domain/use_cases/material/material_use_case.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_event.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const blocMaterial = 'BLOC Material';

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
      dev.log(
          'Active state must => MaterialLoadingState in MaterialLoadingEvent',
          name: blocMaterial);
      emit(MaterialLoadingState());
      final materialList = await getAllMaterialUseCase();
      dev.log(
          'Active state must => OrderMaterialLoadedState in MaterialLoadingEvent',
          name: blocMaterial);
      emit(MaterialLoadedState(materialList: materialList));
    });

    ///Creating new material
    on<MaterialCreatingEvent>((event, emit) {
      final materialEmptyField = createMaterialUseCase.callDefaultFields();
      dev.log(
          'Active state must => MaterialStartFieldsState in MaterialCreatingEvent',
          name: blocMaterial);
      emit(MaterialStartFieldsState(
        emptyFieldId: materialEmptyField.id,
        emptyFieldName: materialEmptyField.name,
        emptyFieldWeightPerCubMeter: materialEmptyField.weightPerCubMeter,
        emptyFieldPricePerCubMeter: materialEmptyField.pricePerCubMeter,
      ));
    });

    /// Created new material
    on<MaterialCreatedEvent>((event, emit) async {
      final response = await createMaterialUseCase.call(
          name: event.name,
          weightPerCubMeter: event.weightPerCubMeter,
          pricePerCubMeter: event.pricePerCubMeter);
      if (response) {
        dev.log(
            'Active state must => MaterialMessageByState in MaterialCreatedEvent',
            name: blocMaterial);
        emit(MaterialMessageByState(
            message: 'Material ${event.name} is created success'));
      }
    });

    /// View one material uses in finish component
    on<MaterialViewByIdEvent>((event, emit) async {
      dev.log(
          'Active state must => MaterialLoadingState in MaterialViewByIdEvent',
          name: blocMaterial);
      emit(MaterialLoadingState());
      final material =
          await getMaterialByIdUseCase(idMaterial: event.idMaterial);
      dev.log(
          'Active state must => MaterialPresentationByIdState in MaterialViewByIdEvent',
          name: blocMaterial);
      emit(MaterialPresentationByIdState(materialEntity: material));
    });

    /// Updating material
    on<MaterialUpdatingEvent>((event, emit) async {
      dev.log(
          'Active state must => MaterialLoadingState in MaterialUpdatingEvent',
          name: blocMaterial);
      emit(MaterialLoadingState());
      final response =
          await getMaterialByIdUseCase(idMaterial: event.idMaterial);
      dev.log(
          'Active state must => MaterialUpdatingFieldsState in MaterialUpdatingEvent',
          name: blocMaterial);
      emit(MaterialUpdatingFieldsState(
          idMaterial: response.id,
          oldFieldName: response.name,
          oldFieldWeightPerCubMeter: response.weightPerCubMeter,
          oldFieldPricePerCubMeter: response.pricePerCubMeter));
    });

    /// Update material
    on<MaterialUpdateEvent>((event, emit) async {
      dev.log(
          'Active state must => MaterialLoadingState in MaterialUpdateEvent',
          name: blocMaterial);
      emit(MaterialLoadingState());
      final response = await updateMaterialUseCase(
          idMaterial: event.idMaterial,
          name: event.name,
          weightPerCubMeter: event.weightPerCubMeter,
          pricePerCubMeter: event.pricePerCubMeter);
      if (response) {
        dev.log(
            'Active state must => MaterialMessageByState in MaterialUpdateEvent',
            name: blocMaterial);
        emit(MaterialMessageByState(
            message: 'Material ${event.name} is updated success'));
      }
    });

    ///Remove material from all place
    on<MaterialDeleteEvent>((event, emit) async {
      dev.log(
          'Active state must => MaterialLoadingState in MaterialDeleteEvent',
          name: blocMaterial);
      emit(MaterialLoadingState());
      final response =
          await deleteMaterialUseCase(idMaterial: event.idMaterial);
      if (response) {
        dev.log(
            'Active state must => MaterialMessageByState in MaterialDeleteEvent',
            name: blocMaterial);
        emit(const MaterialMessageByState(
            message: 'Material is removed success'));
      }
    });

    ///Set id material in ComponentFields and dropdown_button
    on<MaterialSetIdEvent>((event, emit) async {
      dev.log('Active state must => MaterialLoadingState in MaterialSetIdEvent',
          name: blocMaterial);
      emit(MaterialLoadingState());
      final listMaterials = await getAllMaterialUseCase();
      final material = listMaterials.singleWhere(
          (element) => element.id == event.materialId,
          orElse: () => throw Exception(
              'case in MaterialSetIdEvent() when load mistake id'));
      dev.log('Active state must => MaterialSetIdState in MaterialSetIdEvent',
          name: blocMaterial);
      emit(MaterialSetIdState(
        materialEntity: material,
        materialList: listMaterials,
      ));
    });
  }
}
