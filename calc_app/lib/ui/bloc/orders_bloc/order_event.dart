import 'package:calc_app/domain/entities/units_linear.dart';
import 'package:calc_app/domain/entities/units_weight.dart';

abstract class OrderEvent {
  const OrderEvent();
}

class OrderLoadingEvent extends OrderEvent {}

class OrderCreateEvent extends OrderEvent {
  final String name;
  final String description;
  final double width;
  final double length;
  final double height;
  final UnitsLinear unitsLinear;
  final UnitsWeight unitsWeight;

  const OrderCreateEvent({
    required this.name,
    required this.description,
    required this.width,
    required this.length,
    required this.height,
    required this.unitsLinear,
    required this.unitsWeight,
  });
}

class OrderViewByIdEvent extends OrderEvent {
  final String id;

  const OrderViewByIdEvent({
    required this.id,
  });
}

class OrderUpdateEvent extends OrderEvent {
  final String id;
  final String name;
  final String description;
  final double width;
  final double length;
  final double height;
  final UnitsLinear unitsLinear;
  final UnitsWeight unitsWeight;

  const OrderUpdateEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.width,
    required this.length,
    required this.height,
    required this.unitsLinear,
    required this.unitsWeight,
  });
}

class OrderViewWithComponentEvent extends OrderEvent {
  final String id;

  const OrderViewWithComponentEvent({
    required this.id,
  });
}

class ComponentOrderCreateEvent extends OrderEvent {
  final String name;
  final String description;
  final String material;
  final double width;
  final double length;
  final double height;
  final double weight;
  final UnitsLinear unitsLinear;
  final UnitsWeight unitsWeight;
  final int quantity;
  final double weightPerCubMeter;
  final double pricePerCubMeter;

  const ComponentOrderCreateEvent({
    required this.name,
    required this.description,
    required this.material,
    required this.width,
    required this.length,
    required this.height,
    required this.weight,
    required this.unitsLinear,
    required this.unitsWeight,
    required this.quantity,
    required this.weightPerCubMeter,
    required this.pricePerCubMeter,
  });
}

class OrderDeleteEvent extends OrderEvent {
  final String id;

  OrderDeleteEvent({
    required this.id,
  });
}

class ComponentOrderDeletedEvent extends OrderEvent {
  final String idComponent;

  ComponentOrderDeletedEvent({
    required this.idComponent,
  });
}

class ComponentOrderUpdatedEvent extends OrderEvent {
  final String idComponent;
  final String name;
  final String description;
  final String material;
  final double width;
  final double length;
  final double height;
  final double weight;
  final UnitsLinear unitsLinear;
  final UnitsWeight unitsWeight;
  final int quantity;
  final double weightPerCubMeter;
  final double pricePerCubMeter;

  const ComponentOrderUpdatedEvent({
    required this.idComponent,
    required this.name,
    required this.description,
    required this.material,
    required this.width,
    required this.length,
    required this.height,
    required this.weight,
    required this.unitsLinear,
    required this.unitsWeight,
    required this.quantity,
    required this.weightPerCubMeter,
    required this.pricePerCubMeter,
  });
}

class ComponentOrderUpdatingEvent extends OrderEvent {
  // final String idOrder;
  final String idComponent;

  const ComponentOrderUpdatingEvent({
    // required this.idOrder,
    required this.idComponent,
  });
}
