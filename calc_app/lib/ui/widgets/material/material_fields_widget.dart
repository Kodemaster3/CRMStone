import 'package:calc_app/ui/bloc/material_bloc/material_bloc.dart';
import 'package:calc_app/ui/bloc/material_bloc/material_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/screens/catalog_material_screen.dart';
import 'package:calc_app/ui/widgets/navigate/return_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MaterialFieldsWidget extends StatefulWidget {
  final String id;
  final String fieldName;
  final double fieldPricePerCubMeter;
  final double fieldWeightPerCubMeter;

  const MaterialFieldsWidget(
      {Key? key,
      required this.id,
      required this.fieldName,
      required this.fieldPricePerCubMeter,
      required this.fieldWeightPerCubMeter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MaterialFieldsWidgetState();
}

class _MaterialFieldsWidgetState extends State<MaterialFieldsWidget> {
  late TextEditingController _nameController;
  late TextEditingController _weightPerCubMeter;
  late TextEditingController _pricePerCubMeter;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameController = TextEditingController();
    _nameController.text = widget.fieldName;
    _weightPerCubMeter = TextEditingController();
    _weightPerCubMeter.text = widget.fieldWeightPerCubMeter.toString();
    _pricePerCubMeter = TextEditingController();
    _pricePerCubMeter.text = widget.fieldPricePerCubMeter.toString();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _weightPerCubMeter.dispose();
    _pricePerCubMeter.dispose();
    super.dispose();
  }

  void _sendField() {
    setState(() {});
    if (widget.id == '') {
      BlocProvider.of<MaterialBloc>(context).add(MaterialCreatedEvent(
        name: _nameController.text,
        weightPerCubMeter: double.tryParse(_weightPerCubMeter.text) ?? 0.0,
        pricePerCubMeter: double.tryParse(_weightPerCubMeter.text) ?? 0.0,
      ));
    } else {
      BlocProvider.of<MaterialBloc>(context).add(MaterialUpdateEvent(
        idMaterial: widget.id,
        name: _nameController.text,
        weightPerCubMeter: double.tryParse(_weightPerCubMeter.text) ?? 0.0,
        pricePerCubMeter: double.tryParse(_weightPerCubMeter.text) ?? 0.0,
      ));
    }
    scaffoldMessage(context, _nameController.text);

    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    context.read<OrderBloc>().add(OrderLoadingEvent());
    // context.read<MaterialBloc>().add(MaterialLoadingEvent());
    // Navigator.of(context).pushNamedAndRemoveUntil(CatalogMaterialScreen.routeName, (route) => false);
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
            ///Field name in material
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: _nameController.text,
                validator: _validatorStrings,
                onChanged: (value) => _nameController.text = value,
                decoration: const InputDecoration(
                  hintText: 'Write name material',
                  helperText: 'Name material',
                  icon: Icon(Icons.account_tree),
                ),
              ),
            ),

            ///Field weight per cubic meter in material
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: _weightPerCubMeter.text,
                validator: _validatorNumeric,
                onChanged: (value) => _weightPerCubMeter.text = value,
                decoration: const InputDecoration(
                  hintText: 'Write weight per cubic meter',
                  helperText: 'Weight',
                  icon: Icon(Icons.text_snippet_outlined),
                ),
              ),
            ),

            ///Field weight per cubic meter in material
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: _pricePerCubMeter.text,
                validator: _validatorNumeric,
                onChanged: (value) => _pricePerCubMeter.text = value,
                decoration: const InputDecoration(
                  hintText: 'Write price per cubic meter',
                  helperText: 'Price',
                  icon: Icon(Icons.text_snippet_outlined),
                ),
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ReturnHome(),
            ),
          ],
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
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("added material $text success")));
  }
}
