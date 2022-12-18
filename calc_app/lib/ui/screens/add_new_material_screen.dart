import 'package:calc_app/ui/widgets/material/material_fields_widget.dart';
import 'package:calc_app/ui/widgets/navigate/return_home.dart';
import 'package:flutter/material.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_bloc.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_state.dart'
    as state_bloc;
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewMaterialScreen extends StatelessWidget {
  static const routeName = '/AddNewMaterialScreen';

  const AddNewMaterialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material'),
      ),
      body: BlocBuilder<MaterialBloc, state_bloc.MaterialState>(
        builder: (context, state) {
          /// When fields fill => submit add MaterialCreatedEvent
          if (state is state_bloc.MaterialStartFieldsState) {
            return MaterialFieldsWidget(
                id: state.emptyFieldId,
                fieldName: state.emptyFieldName,
                fieldPricePerCubMeter: state.emptyFieldPricePerCubMeter,
                fieldWeightPerCubMeter: state.emptyFieldWeightPerCubMeter);
          }

          /// When fields fill => submit add MaterialUpdateEvent
          if (state is state_bloc.MaterialUpdatingFieldsState) {
            return MaterialFieldsWidget(
                id: state.idMaterial,
                fieldName: state.oldFieldName,
                fieldPricePerCubMeter: state.oldFieldPricePerCubMeter,
                fieldWeightPerCubMeter: state.oldFieldWeightPerCubMeter);
          }
          return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max,
            children: const [
              CircularProgressIndicator(),
              ReturnHome(),
            ],
          );
        },
      ),
    );
  }
}
