import 'package:calc_app/ui/bloc/orders_bloc/order_bloc.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_event.dart';
import 'package:calc_app/ui/bloc/orders_bloc/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateComponentFieldWidget extends StatelessWidget {
  UpdateComponentFieldWidget({Key? key}) : super(key: key);

  final _fl = FieldLink();

  @override
  Widget build(BuildContext context) {
    //TODO add requirements for empty field
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is ComponentEditingField) {
          _fl.length = state.componentEntity.length;
          _fl.material = state.componentEntity.material;
          _fl.quantity = state.componentEntity.quantity;
          _fl.pricePerCubMeter = state.componentEntity.pricePerCubMeter;
          _fl.weightPerCubMeter = state.componentEntity.weightPerCubMeter;
          _fl.width = state.componentEntity.width;
          _fl.height = state.componentEntity.height;
          _fl.name = state.componentEntity.name;
          return Column(
            children: [
              TextFormField(
                controller: TextEditingController(text: _fl.name),
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
                controller: TextEditingController(text: _fl.material),
                onChanged: (value) => _fl.material = value,
                onFieldSubmitted: (_) {},
                decoration: const InputDecoration(hintText: 'Material'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: _fl.height.toString()),
                onChanged: (value) =>
                    _fl.height = double.tryParse(value) ?? 0.0,
                onFieldSubmitted: (_) {},
                decoration: const InputDecoration(hintText: 'Height'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: _fl.length.toString()),
                onChanged: (value) =>
                    _fl.length = double.tryParse(value) ?? 0.0,
                onFieldSubmitted: (_) {},
                decoration: const InputDecoration(hintText: 'Length'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller:
                    TextEditingController(text: _fl.quantity.toString()),
                onChanged: (value) => _fl.quantity = int.tryParse(value) ?? 0,
                onFieldSubmitted: (_) {},
                decoration: const InputDecoration(hintText: 'Quantity'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: TextEditingController(
                    text: _fl.weightPerCubMeter.toString()),
                onChanged: (value) =>
                    _fl.weightPerCubMeter = double.tryParse(value) ?? 0.0,
                onFieldSubmitted: (_) {},
                decoration:
                    const InputDecoration(hintText: 'Weight Per Cub to Meter'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: _fl.width.toString()),
                onChanged: (value) => _fl.width = double.tryParse(value) ?? 0.0,
                onFieldSubmitted: (_) {},
                decoration: const InputDecoration(hintText: 'Width'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: TextEditingController(
                    text: _fl.pricePerCubMeter.toString()),
                onChanged: (value) =>
                    _fl.pricePerCubMeter = double.tryParse(value) ?? 0.0,
                onFieldSubmitted: (_) {},
                decoration:
                    const InputDecoration(hintText: 'Price Per Cub Meter'),
              ),
              TextButton(
                child: const Text('Submit'),
                onPressed: () {
                  BlocProvider.of<OrderBloc>(context)
                      .add(ComponentOrderUpdatedEvent(
                    idComponent: state.componentEntity.id,
                    name: _fl.name,
                    material: _fl.material,
                    height: _fl.height,
                    length: _fl.length,
                    quantity: _fl.quantity,
                    weightPerCubMeter: _fl.weightPerCubMeter,
                    width: _fl.width,
                    pricePerCubMeter: _fl.pricePerCubMeter,
                  ));
                  BlocProvider.of<OrderBloc>(context)
                      .add(OrderViewWithComponentEvent(id: state.idOrder));
                  scaffoldMessage(context, _fl.name);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
  void scaffoldMessage(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("update component $text success")));
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
