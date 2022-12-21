import 'dart:developer' as dev;

import 'package:calc_app/domain/entities/material.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_bloc.dart'
    as material_bloc;
import 'package:calc_app/ui/bloc/material_bloc/material_event.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_state.dart'
    as material_state;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialViewListDropdownSearchWidget extends StatelessWidget {
  final String materialId;

  const MaterialViewListDropdownSearchWidget(
      {required this.materialId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<material_bloc.MaterialBloc,
        material_state.MaterialState>(builder: (context, state) {
      dev.log(
          'method build in MaterialViewListDropdownSearchWidget => BlocBuilder => $state',
          name: 'ui read state');

      if (state is material_state.MaterialLoadedState) {
        return DropdownSearch<MaterialEntity>(
          items: state.materialList,
          itemAsString: (MaterialEntity entity) => entity.name,
          onChanged: (MaterialEntity? data) =>
              BlocProvider.of<material_bloc.MaterialBloc>(context)
                  .add(MaterialSetIdEvent(materialId: data!.id)),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(helperText: "Material"),
          ),
        );
      }
      if (state is material_state.MaterialSetIdState) {
        return DropdownSearch<MaterialEntity>(

          items: state.materialList,
          itemAsString: (MaterialEntity entity) => entity.name,
          selectedItem: state.materialEntity,
          // widget.materialId == '' ? null : state.materialEntity,
          onChanged: (MaterialEntity? data) =>
              BlocProvider.of<material_bloc.MaterialBloc>(context)
                  .add(MaterialSetIdEvent(materialId: data!.id)),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(helperText: "Material"),
          ),
        );
      }
      return const CircularProgressIndicator();
    });
  }
}
