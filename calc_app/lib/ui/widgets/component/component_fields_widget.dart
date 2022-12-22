import 'dart:developer' as dev;
import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_bloc.dart' as mb;
import 'package:calc_app/ui/bloc/material_bloc/material_event.dart' as me;
import 'package:calc_app/ui/bloc/material_bloc/material_state.dart' as ms;
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/screens/view_order_screen_with_component.dart';
import 'package:calc_app/ui/widgets/material/material_view_list_dropdown_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ComponentFieldsWidget extends StatefulWidget {
  final String idOrder;
  final String idComponent;
  final String name;
  final String description;
  final String materialId;
  final double width;
  final double length;
  final double height;
  final double weight;
  final int quantity;
  final UnitsLinear unitLinear;
  final UnitsWeight unitWeight;

  const ComponentFieldsWidget({
    Key? key,
    required this.idOrder,
    required this.idComponent,
    required this.name,
    required this.description,
    required this.materialId,
    required this.width,
    required this.length,
    required this.height,
    required this.unitLinear,
    required this.unitWeight,
    required this.quantity,
    required this.weight,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ComponentFieldsWidget();
}

class _ComponentFieldsWidget extends State<ComponentFieldsWidget> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _materialIdController;
  late TextEditingController _sizeWidthController;
  late TextEditingController _sizeLengthController;
  late TextEditingController _sizeHeightController;
  late TextEditingController _quantityController;
  late TextEditingController _weightController;
  late UnitsLinear _unitLinear;
  late UnitsWeight _unitWeight;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loadingMaterialState();
    _nameController = TextEditingController();
    _nameController.text = widget.name;
    _descriptionController = TextEditingController();
    _descriptionController.text = widget.description;
    _sizeWidthController = TextEditingController();
    _sizeWidthController.text = widget.width.toString();
    _sizeLengthController = TextEditingController();
    _sizeLengthController.text = widget.length.toString();
    _sizeHeightController = TextEditingController();
    _sizeHeightController.text = widget.height.toString();
    _quantityController = TextEditingController();
    _quantityController.text = widget.quantity.toString();
    _weightController = TextEditingController();
    _weightController.text = widget.weight.toString();
    _unitLinear = widget.unitLinear;
    _unitWeight = widget.unitWeight;
    _materialIdController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _sizeWidthController.dispose();
    _sizeLengthController.dispose();
    _sizeHeightController.dispose();
    _quantityController.dispose();
    _weightController.dispose();
    _materialIdController.dispose();
    super.dispose();
  }

  void _sendField() {
    setState(() {});
    if (_materialIdController.text == '' ||
        _materialIdController.text.isEmpty) {
      scaffoldMessage(context, 'need make chose material');
    } else if (widget.idComponent == '') {
      BlocProvider.of<OrderBloc>(context).add(ComponentOrderCreateEvent(
        idOrder: widget.idOrder,
        name: _nameController.text,
        description: _descriptionController.text,
        materialId: _materialIdController.text,
        width: double.tryParse(_sizeWidthController.text) ?? 0.0,
        length: double.tryParse(_sizeLengthController.text) ?? 0.0,
        height: double.tryParse(_sizeHeightController.text) ?? 0.0,
        weight: double.tryParse(_weightController.text) ?? 0.0,
        unitsLinear: _unitLinear,
        unitsWeight: _unitWeight,
        quantity: int.tryParse(_quantityController.text) ?? 0,
      ));
      scaffoldMessage(
          context, 'Create component ${_nameController.text} success');

      Navigator.of(context).pushNamed(ViewOrderScreenWithListComponent.routeName);
      BlocProvider.of<OrderBloc>(context)
          .add(OrderViewWithComponentEvent(id: widget.idOrder));
    } else {
      BlocProvider.of<OrderBloc>(context).add(ComponentOrderUpdatedEvent(
        idOrder: widget.idOrder,
        idComponent: widget.idComponent,
        name: _nameController.text,
        description: _descriptionController.text,
        material: _materialIdController.text,
        width: double.tryParse(_sizeWidthController.text) ?? 0.0,
        length: double.tryParse(_sizeLengthController.text) ?? 0.0,
        height: double.tryParse(_sizeHeightController.text) ?? 0.0,
        weight: double.tryParse(_weightController.text) ?? 0.0,
        unitsLinear: _unitLinear,
        unitsWeight: _unitWeight,
        quantity: int.tryParse(_quantityController.text) ?? 0,
      ));
      scaffoldMessage(
          context, 'Update component ${_nameController.text} success');

      Navigator.of(context).pushNamed(ViewOrderScreenWithListComponent.routeName);
      BlocProvider.of<OrderBloc>(context)
          .add(OrderViewWithComponentEvent(id: widget.idOrder));

      BlocProvider.of<mb.MaterialBloc>(context).add(me.MaterialLoadingEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<mb.MaterialBloc, ms.MaterialState>(
      listener: (context, state) {
        dev.log(
            'method build in ComponentFieldsWidget => BlocListener => $state',
            name: 'ui read state');
        if (state is ms.MaterialSetIdState) {
          _materialIdController.text = state.materialEntity.id;
        }
      },
      child: Form(
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
                  onChanged: (value) => _nameController.text = value,
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
                  onChanged: (value) => _descriptionController.text = value,
                  decoration: const InputDecoration(
                    hintText: 'Write description component',
                    helperText: 'Description',
                    icon: Icon(Icons.text_snippet_outlined),
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
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                        ],
                        onChanged: (value) =>
                            _sizeHeightController.text = value,
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
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                        ],
                        onChanged: (value) =>
                            _sizeLengthController.text = value,
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
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                        ],
                        onChanged: (value) => _sizeWidthController.text = value,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _quantityController.text,
                        validator: _validatorNumeric,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                        ],
                        onChanged: (value) => _quantityController.text = value,
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

                    const Spacer(),

                    ///Dropdown material
                    Expanded(
                      child: MaterialViewListDropdownSearchWidget(
                          materialId: widget.materialId),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _weightController.text,
                  validator: _validatorNumeric,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                  ],
                  onChanged: (value) => _weightController.text = value,
                  decoration: const InputDecoration(
                    hintText: 'Weight component',
                    helperText: 'Weight component',
                    icon: Icon(
                      Icons.monitor_weight_outlined,
                      size: 15.0,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  child: Text(
                    widget.idComponent == ''
                        ? 'Add component'
                        : 'Update Component',
                    style: const TextStyle(
                      color: Colors.brown,
                      backgroundColor: Colors.black12,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendField();
                      //TODO dose that event work? need check!!!!
                      // Navigator.of(context).pushNamed('/ViewOrderScreenWithListComponent');
                      // BlocProvider.of<OrderBloc>(context).add(OrderViewWithComponentEvent(id: widget.idOrder));
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _loadingMaterialState() {
    dev.log(widget.materialId, name: 'ui _loadingMaterialState');
    if (widget.materialId == '') {
      BlocProvider.of<mb.MaterialBloc>(context).add(me.MaterialLoadingEvent());
    } else {
      BlocProvider.of<mb.MaterialBloc>(context)
          .add(me.MaterialSetIdEvent(materialId: widget.materialId));
    }
  }
}
