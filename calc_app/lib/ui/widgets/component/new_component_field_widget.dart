import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NewComponentFieldWidget extends StatefulWidget {
  const NewComponentFieldWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewComponentFieldWidget();
}

class _NewComponentFieldWidget extends State<NewComponentFieldWidget> {
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
    _unitLinear = UnitsLinear.meter;
    _unitWeight = UnitsWeight.kilogram;
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

  void _sendField() {
    BlocProvider.of<OrderBloc>(context).add(ComponentOrderCreateEvent(
      name: _nameController.text,
      description: _descriptionController.text,
      material: _materialController.text,
      quantity: int.tryParse(_quantityController.text) ?? 0,
      width: double.tryParse(_sizeWidthController.text) ?? 0.0,
      length: double.tryParse(_sizeLengthController.text) ?? 0.0,
      height: double.tryParse(_sizeHeightController.text) ?? 0.0,
      unitsLinear: _unitLinear,
      unitsWeight: _unitWeight,
      weightPerCubMeter: double.tryParse(_weightPerCubMeterController.text) ?? 0.0,
      pricePerCubMeter: double.tryParse(_pricePerCubMeterController.text) ?? 0.0,
    ));
    scaffoldMessage(context, _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
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
                      initialValue: (0.0).toString(),
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
                      initialValue: (0.0).toString(),
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
                      initialValue: (0.0).toString(),
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
                      initialValue: (0.0).toString(),
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
                      initialValue: (0.0).toString(),
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
                      initialValue: (0.0).toString(),
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
                  'Add Comp',
                  style: TextStyle(
                    color: Colors.brown,
                    backgroundColor: Colors.black12,
                    fontSize: 16.0,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _sendField();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );

    //   Column(
    //   children: [
    //     TextFormField(
    //       onChanged: (value) => _fl.name = value,
    //       onFieldSubmitted: (_) {},
    //       decoration: const InputDecoration(hintText: 'Name'),
    //     ),
    //     //TODO: Plan use it when data implement description
    //     TextFormField(
    //       controller: TextEditingController(text: _fl.description),
    //       maxLines: 3,
    //       onChanged: (value) => _fl.description = value,
    //       onFieldSubmitted: (_) {},
    //       decoration: const InputDecoration(hintText: 'Description'),
    //     ),
    //     TextFormField(
    //       onChanged: (value) => _fl.material = value,
    //       onFieldSubmitted: (_) {},
    //       decoration: const InputDecoration(hintText: 'Material'),
    //     ),
    //     // TextFormField(
    //     //   keyboardType: TextInputType.number,
    //     //   onChanged: (value) => _fl.height = double.tryParse(value) ?? 0.0,
    //     //   onFieldSubmitted: (_) {},
    //     //   decoration: const InputDecoration(hintText: 'Height'),
    //     // ),
    //     // TextFormField(
    //     //   keyboardType: TextInputType.number,
    //     //   onChanged: (value) => _fl.length = double.tryParse(value) ?? 0.0,
    //     //   onFieldSubmitted: (_) {},
    //     //   decoration: const InputDecoration(hintText: 'Length'),
    //     // ),
    //     TextFormField(
    //       keyboardType: TextInputType.number,
    //       onChanged: (value) => _fl.quantity = int.tryParse(value) ?? 0,
    //       onFieldSubmitted: (_) {},
    //       decoration: const InputDecoration(hintText: 'Quantity'),
    //     ),
    //     TextFormField(
    //       keyboardType: TextInputType.number,
    //       onChanged: (value) =>
    //           _fl.weightPerCubMeter = double.tryParse(value) ?? 0.0,
    //       onFieldSubmitted: (_) {},
    //       decoration:
    //           const InputDecoration(hintText: 'Weight Per Cub to Meter'),
    //     ),
    //     // TextFormField(
    //     //   keyboardType: TextInputType.number,
    //     //   onChanged: (value) => _fl.width = double.tryParse(value) ?? 0.0,
    //     //   onFieldSubmitted: (_) {},
    //     //   decoration: const InputDecoration(hintText: 'Width'),
    //     // ),
    //     TextFormField(
    //       keyboardType: TextInputType.number,
    //       onChanged: (value) =>
    //           _fl.pricePerCubMeter = double.tryParse(value) ?? 0.0,
    //       onFieldSubmitted: (_) {},
    //       decoration: const InputDecoration(hintText: 'Price Per Cub Meter'),
    //     ),
    //     TextButton(
    //       child: const Text('Add Comp'),
    //       onPressed: () {
    //         _sendField();
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //   ],
    // );
  }

  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("added component $text success")));
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
}