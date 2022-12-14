import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';



class UpdateComponentFieldWidget extends StatefulWidget {
  const UpdateComponentFieldWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UpdateComponentFieldWidgetState();
}

class _UpdateComponentFieldWidgetState
    extends State<UpdateComponentFieldWidget> {
  bool _flagUpdate = true;

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _sizeWidthController;
  late TextEditingController _sizeLengthController;
  late TextEditingController _sizeHeightController;
  late TextEditingController _materialController;
  late TextEditingController _quantityController;
  late TextEditingController _weightPerCubMeterController;
  late TextEditingController _pricePerCubMeterController;
  late UnitsLinear _unitLinear;
  late UnitsWeight _unitWeight;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _sizeWidthController = TextEditingController();
    _sizeLengthController = TextEditingController();
    _sizeHeightController = TextEditingController();
    _materialController = TextEditingController();
    _quantityController = TextEditingController();
    _weightPerCubMeterController = TextEditingController();
    _pricePerCubMeterController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _sizeWidthController.dispose();
    _sizeLengthController.dispose();
    _sizeHeightController.dispose();
    _materialController.dispose();
    _quantityController.dispose();
    _weightPerCubMeterController.dispose();
    _pricePerCubMeterController.dispose();
    super.dispose();
  }

  void _updateField(String inComponent) {
    BlocProvider.of<OrderBloc>(context).add(
      ComponentOrderUpdatedEvent(
          idComponent: inComponent,
          name: _nameController.text,
          description: _descriptionController.text,
          material: _materialController.text,
          width: double.tryParse(_sizeWidthController.text) ?? 0.0,
          length: double.tryParse(_sizeLengthController.text) ?? 0.0,
          height: double.tryParse(_sizeHeightController.text) ?? 0.0,
          unitsLinear: _unitLinear,
          unitsWeight: _unitWeight,
          quantity: int.tryParse(_quantityController.text) ?? 0,
          weightPerCubMeter:
              double.tryParse(_weightPerCubMeterController.text) ?? 0.0,
          pricePerCubMeter: double.tryParse(
                _pricePerCubMeterController.text,
              ) ??
              0.0),
    );
    scaffoldMessage(context, _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is ComponentEditingField) {
          if (_flagUpdate) {
          print('rebuild component');
          setValueFromState(state);
        }
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Field name in component

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _nameController.text,
                      validator: _validatorStrings,
                      onChanged: (value) => setState(() {
                        _nameController.text = value;
                      }),
                      decoration: const InputDecoration(
                        hintText: 'Write name component',
                        helperText: 'Name',
                        icon: Icon(Icons.account_tree),
                      ),
                    ),
                  ),

                  ///Field description in component

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _descriptionController.text,
                      validator: _validatorStrings,
                      maxLines: 2,
                      onChanged: (value) => setState(() {
                        _descriptionController.text = value;
                      }),
                      decoration: const InputDecoration(
                        hintText: 'Write description component',
                        helperText: 'Description',
                        icon: Icon(Icons.text_snippet_outlined),
                      ),
                    ),
                  ),

                  ///Field material in component

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: _materialController.text,
                      validator: _validatorStrings,
                      onChanged: (value) => setState(() {
                        _materialController.text = value;
                      }),
                      decoration: const InputDecoration(
                        hintText: 'Write material',
                        helperText: 'Material',
                        icon: Icon(Icons.medical_information_outlined),
                      ),
                    ),
                  ),

                  ///Fields size in component

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: _sizeHeightController.text,
                            validator: _validatorNumeric,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'))
                            ],
                            onChanged: (value) => setState(() {
                              _sizeHeightController.text = value;
                            }),
                            decoration: const InputDecoration(
                              hintText: 'Height component',
                              helperText: 'Height',
                              icon: Icon(
                                Icons.height,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: _sizeLengthController.text,
                            validator: _validatorNumeric,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'))
                            ],
                            onChanged: (value) => setState(() {
                              _sizeLengthController.text = value;
                            }),
                            decoration: const InputDecoration(
                              hintText: 'Length component',
                              helperText: 'Length',
                              icon: Icon(
                                Icons.open_in_full,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: _sizeWidthController.text,
                            validator: _validatorNumeric,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'))
                            ],
                            onChanged: (value) => setState(() {
                              _sizeWidthController.text = value;
                            }),
                            decoration: const InputDecoration(
                              hintText: 'Width component',
                              helperText: 'Width',
                              icon: Icon(
                                Icons.swap_horiz,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleSwitch(
                      animate: true,
                      inactiveBgColor: Colors.black12,
                      fontSize: 12.0,
                      initialLabelIndex: _unitLinear.index,
                      totalSwitches: UnitsLinear.values.length,
                      labels: UnitsLinear.values
                          .map((e) => e.name.toUpperCase())
                          .toList(),
                      onToggle: (index) {
                        _unitLinear = UnitsLinear.values[index!];
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ToggleSwitch(
                      animate: true,
                      inactiveBgColor: Colors.black12,
                      fontSize: 12.0,
                      initialLabelIndex: _unitWeight.index,
                      totalSwitches: UnitsWeight.values.length,
                      labels: UnitsWeight.values
                          .map((e) => e.name.toUpperCase())
                          .toList(),
                      onToggle: (index) {
                        _unitWeight = UnitsWeight.values[index!];
                      },
                    ),
                  ),

                  ///Fields weight quantity price

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: _quantityController.text,
                            validator: _validatorNumeric,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'))
                            ],
                            onChanged: (value) => setState(() {
                              _quantityController.text = value;
                            }),
                            decoration: const InputDecoration(
                              hintText: 'Quantity in component',
                              helperText: 'Quantity',
                              icon: Icon(
                                Icons.countertops_outlined,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: _weightPerCubMeterController.text,
                            validator: _validatorNumeric,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'))
                            ],
                            onChanged: (value) => setState(() {
                              _weightPerCubMeterController.text = value;
                            }),
                            decoration: const InputDecoration(
                              hintText: 'WeightPerCubMeter',
                              helperText: 'WeightPerCubMeter',
                              icon: Icon(
                                Icons.monitor_weight_outlined,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: _pricePerCubMeterController.text,
                            validator: _validatorNumeric,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'))
                            ],
                            onChanged: (value) => setState(() {
                              _pricePerCubMeterController.text = value;
                            }),
                            decoration: const InputDecoration(
                              hintText: 'PricePerCubMeter',
                              helperText: 'PricePerCubMeter',
                              icon: Icon(
                                Icons.price_change_outlined,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: const Text(
                        'Update Component',
                        style: TextStyle(
                          color: Colors.brown,
                          backgroundColor: Colors.black12,
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _updateField(state.componentEntity.id);
                          //TODO dose that event work? need check!!!!
                          print(state.idOrder);
                          // BlocProvider.of<OrderBloc>(context).add(
                          //     OrderViewWithComponentEvent(id: state.idOrder));
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  void setValueFromState(ComponentEditingField state) {
    print(state.componentEntity.name);
    print(_nameController.text);
    _nameController.text = state.componentEntity.name;
    _descriptionController.text = state.componentEntity.description;
    _materialController.text = state.componentEntity.material;
    _sizeWidthController.text = state.componentEntity.size.width.toString();
    _sizeLengthController.text = state.componentEntity.size.length.toString();
    _sizeHeightController.text = state.componentEntity.size.height.toString();
    _quantityController.text = state.componentEntity.quantity.toString();
    _unitWeight = state.componentEntity.unitsWeight;
    _unitLinear = state.componentEntity.size.unitsLinear;
    _weightPerCubMeterController.text =
        state.componentEntity.weightPerCubMeter.toString();
    _pricePerCubMeterController.text =
        state.componentEntity.pricePerCubMeter.toString();
    _flagUpdate = !_flagUpdate;
  }

  String? _validatorStrings(value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    if (value.length < 4) {
      return 'Please write long text';
    }
    return null;
  }

  String? _validatorNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("update component $text success")));
  }
}
