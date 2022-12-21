import 'dart:developer' as dev;

import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddNewOrderScreen extends StatefulWidget {
  static const routeName = '/AddNewOrderScreen';

  const AddNewOrderScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddNewOrderScreenState();
}

class _AddNewOrderScreenState extends State<AddNewOrderScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _sizeWidthController;
  late TextEditingController _sizeLengthController;
  late TextEditingController _sizeHeightController;
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
    super.dispose();
  }

  void _sendField() {
    setState(() {});
    BlocProvider.of<OrderBloc>(context).add(OrderCreateEvent(
      name: _nameController.text,
      description: _descriptionController.text,
      width: double.tryParse(_sizeWidthController.text) ?? 0.0,
      length: double.tryParse(_sizeLengthController.text) ?? 0.0,
      height: double.tryParse(_sizeHeightController.text) ?? 0.0,
      unitsLinear: _unitLinear,
      unitsWeight: _unitWeight,
    ));

    scaffoldMessage(context, _nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScreenAddOrder'),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          dev.log('method build in AddNewOrderScreen => BlocBuilder => $state', name: 'ui read state');
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///Field name in order
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: _validatorStrings,
                      onChanged: (value) =>
                        _nameController.text = value,

                      decoration: const InputDecoration(
                        hintText: 'Write name order',
                        helperText: 'Name',
                        icon: Icon(Icons.account_tree),
                      ),
                    ),
                  ),

                  ///Field description in order
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: _validatorStrings,
                      maxLines: 3,
                      onChanged: (value) =>
                        _descriptionController.text = value,

                      decoration: const InputDecoration(
                        hintText: 'Write description order',
                        helperText: 'Description',
                        icon: Icon(Icons.text_snippet_outlined),
                      ),
                    ),
                  ),

                  ///Fields size in order
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
                            onChanged: (value) =>
                              _sizeHeightController.text = value,

                            decoration: const InputDecoration(
                              hintText: 'Height order',
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
                            onChanged: (value) =>
                              _sizeLengthController.text = value,

                            decoration: const InputDecoration(
                              hintText: 'Length order',
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
                            onChanged: (value) =>
                              _sizeWidthController.text = value
                            ,
                            decoration: const InputDecoration(
                              hintText: 'Width order',
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      child: const Text(
                        'Check correct form and create',
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
        },
      ),
    );
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

  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("added order $text success")));
  }

  String? _validatorNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }
}
