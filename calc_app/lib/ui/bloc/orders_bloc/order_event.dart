abstract class OrderEvent {
  const OrderEvent();
}

class OrderLoadingEvent extends OrderEvent {}

class OrderCreateEvent extends OrderEvent {
  final String name;
  final String description;

  const OrderCreateEvent({
    required this.name,
    required this.description,
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

  const OrderUpdateEvent({
    required this.id,
    required this.name,
    required this.description,
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
  final String material;
  final double height;
  final double length;
  final int quantity;
  final double weightPerCubMeter;
  final double width;
  final double pricePerCubMeter;

  const ComponentOrderCreateEvent({
    required this.name,
    required this.material,
    required this.height,
    required this.length,
    required this.quantity,
    required this.weightPerCubMeter,
    required this.width,
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
  final String material;
  final double height;
  final double length;
  final int quantity;
  final double weightPerCubMeter;
  final double width;
  final double pricePerCubMeter;

  const ComponentOrderUpdatedEvent({
    required this.idComponent,
    required this.name,
    required this.material,
    required this.height,
    required this.length,
    required this.quantity,
    required this.weightPerCubMeter,
    required this.width,
    required this.pricePerCubMeter,
  });
}

class ComponentOrderUpdatingEvent extends OrderEvent {
  final String idOrder;
  final String idComponent;

  const ComponentOrderUpdatingEvent({
    required this.idOrder,
    required this.idComponent,
  });
}
