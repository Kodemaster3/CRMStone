import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NewComponentFieldWidget extends StatelessWidget {
  NewComponentFieldWidget({Key? key}) : super(key: key);

 final _fl = FieldLink();

  @override
  Widget build(BuildContext context) {
    //TODO add requirements for empty field
    return Column(
      children: [
        TextFormField(
          onChanged: (value) => _fl.name = value,
          onFieldSubmitted: (_) {},
          decoration: const InputDecoration(hintText: 'Name'),
        ),
        //TODO: Plan use it when data implement description
        // TextFormField(
        //   maxLines: 3,
        //   onChanged: (value) => _fl.description = decription,
        //   onFieldSubmitted: (_) {},
        // ),
        TextFormField(
          onChanged: (value) => _fl.material = value,
          onFieldSubmitted: (_) {},
          decoration: const InputDecoration(hintText: 'Material'),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) =>
          _fl.height = double.tryParse(value) ?? 0.0,
          onFieldSubmitted: (_) {},
          decoration: const InputDecoration(hintText: 'Height'),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) =>
          _fl.length = double.tryParse(value) ?? 0.0,
          onFieldSubmitted: (_) {},
          decoration: const InputDecoration(hintText: 'Length'),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) => _fl.quantity = int.tryParse(value) ?? 0,
          onFieldSubmitted: (_) {},
          decoration: const InputDecoration(hintText: 'Quantity'),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) =>
          _fl.weightPerCubMeter = double.tryParse(value) ?? 0.0,
          onFieldSubmitted: (_) {},
          decoration:
          const InputDecoration(hintText: 'Weight Per Cub to Meter'),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) => _fl.width = double.tryParse(value) ?? 0.0,
          onFieldSubmitted: (_) {},
          decoration: const InputDecoration(hintText: 'Width'),
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          onChanged: (value) =>
          _fl.pricePerCubMeter = double.tryParse(value) ?? 0.0,
          onFieldSubmitted: (_) {},
          decoration:
          const InputDecoration(hintText: 'Price Per Cub Meter'),
        ),
        TextButton(
          child: const Text('Add Comp'),
          onPressed: () {
            BlocProvider.of<OrderBloc>(context).add(
                ComponentOrderCreateEvent(
                    name: _fl.name,
                    material: _fl.material,
                    height: _fl.height,
                    length: _fl.length,
                    quantity: _fl.quantity,
                    weightPerCubMeter: _fl.weightPerCubMeter,
                    width: _fl.width,
                    pricePerCubMeter: _fl.pricePerCubMeter));
            scaffoldMessage(context, _fl.name);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("added component $text success")));
  }

}

class FieldLink {
  String name = '';
  String material = '';
  double height = 0.0;
  double length = 0.0;
  int quantity = 0;
  double weightPerCubMeter = 0.0;
  double width = 0.0;
  double pricePerCubMeter = 0.0;
}