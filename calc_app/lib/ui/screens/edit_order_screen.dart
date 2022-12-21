import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditOrderScreen extends StatefulWidget {
  static const routeName = '/EditOrderScreen';

  const EditOrderScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  bool _flagInit = true;

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

  void _sendUpdate(BuildContext context, String id) {
    setState(() {});
    BlocProvider.of<OrderBloc>(context).add(
      OrderUpdateEvent(
        id: id,
        name: _nameController.text,
        description: _descriptionController.text,
        width: double.tryParse(_sizeWidthController.text) ?? 0.0,
        length: double.tryParse(_sizeLengthController.text) ?? 0.0,
        height: double.tryParse(_sizeHeightController.text) ?? 0.0,
        unitsLinear: _unitLinear,
        unitsWeight: _unitWeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoaded) {
          if (_flagInit) {
            setValueFromState(state);
          }
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () {
                    BlocProvider.of<OrderBloc>(context)
                        .add(OrderDeleteEvent(id: state.order.id));
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                ),
              ],
              title: Text(state.order.name),
              automaticallyImplyLeading: false,
            ),
            body: Form(
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
                        initialValue: _nameController.text,
                        validator: _validatorStrings,
                        onChanged: (value) => _nameController.text = value,
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
                        initialValue: _descriptionController.text,
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
                              initialValue: _sizeHeightController.text,
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
                              initialValue: _sizeLengthController.text,
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
                              initialValue: _sizeWidthController.text,
                              validator: _validatorNumeric,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.]'))
                              ],
                              onChanged: (value) =>
                                  _sizeWidthController.text = value,
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

                    ///ToggleSwitchers

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ToggleSwitch(
                        animate: true,
                        inactiveBgColor: Colors.black12,
                        fontSize: 12.0,
                        initialLabelIndex: _updateValueUnitsLinear(
                            state.order.size.unitsLinear.index),
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
                        //TODO implement correct view state and callback
                        initialLabelIndex:
                            // _unitWeight.index,
                            _updateValueUnitWeight(
                                state.order.unitsWeight.index),
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
                          'Check correct form and update',
                          style: TextStyle(
                            color: Colors.brown,
                            backgroundColor: Colors.black12,
                            fontSize: 16.0,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _sendUpdate(context, state.order.id);
                            Navigator.of(context)
                                .pushNamedAndRemoveUntil('/', (route) => false);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const CircularProgressIndicator();
      },
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

  String? _validatorNumeric(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  int _updateValueUnitsLinear(int index) {
    _unitLinear = UnitsLinear.values[index];
    return index;
  }

  int _updateValueUnitWeight(int index) {
    _unitWeight = UnitsWeight.values[index];
    return index;
  }

  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Updated order $text success")));
  }

  void setValueFromState(OrderLoaded state) {
    _nameController.text = state.order.name;
    _descriptionController.text = state.order.description;
    _sizeWidthController.text = state.order.size.width.toString();
    _sizeLengthController.text = state.order.size.length.toString();
    _sizeHeightController.text = state.order.size.height.toString();
    _unitLinear = state.order.size.unitsLinear;
    // TODO make correct that
    _unitWeight = state.order.unitsWeight;
    _flagInit = !_flagInit;
  }
}
