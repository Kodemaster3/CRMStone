import 'package:calc_app/ui/bloc/material_bloc/material_state.dart';
import 'package:calc_app/ui/screens/add_new_material_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_bloc.dart' as m_b;
import 'package:calc_app/ui/bloc/material_bloc/material_event.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_state.dart' as m_s;

class CatalogMaterialScreen extends StatelessWidget {
  static const routeName = '/CatalogMaterialScreen';

  const CatalogMaterialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material catalog'),
      ),
      body: BlocBuilder<m_b.MaterialBloc, m_s.MaterialState>(
        builder: (context, state) {
          if (state is MaterialLoadedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.materialList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Text(
                              state.materialList[index].name,
                            ),

                            /// Edit Material by id
                            onTap: () {
                              BlocProvider.of<m_b.MaterialBloc>(context).add(
                                  MaterialUpdatingEvent(
                                      idMaterial:
                                          state.materialList[index].id));
                              Navigator.of(context).pushReplacementNamed(
                                  AddNewMaterialScreen.routeName);
                            },
                          ),

                          /// Remove material
                          /// When accepted => return to same update page
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<m_b.MaterialBloc>(context).add(
                                  MaterialDeleteEvent(
                                      idMaterial:
                                          state.materialList[index].id));
                              Navigator.of(context)
                                  .pushReplacementNamed(routeName);
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    );
                  },
                ),

                ///add material
                TextButton(
                  child: const Text('Add new Material'),
                  onPressed: () {
                    // BlocProvider.of<MaterialBloc>(context).add(MaterialCreatingEvent());
                    context
                        .read<m_b.MaterialBloc>()
                        .add(MaterialCreatingEvent());
                    Navigator.of(context)
                        .pushNamed(AddNewMaterialScreen.routeName);
                  },
                  // icon: const Icon(Icons.medical_information_outlined),
                ),
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
