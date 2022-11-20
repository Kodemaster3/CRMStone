abstract class OrderEvent {
  const OrderEvent();
}

class OrderLoadingEvent extends OrderEvent {}

class OrderCreateEvent extends OrderEvent {
  final String name;
  final String description;
  OrderCreateEvent({required this.name, required this.description});
}

class OrderEditingEvent extends OrderEvent {
  final String id;
  OrderEditingEvent({required this.id});
}

class OrderUpdateEvent extends OrderEvent {
  final String id;
  final String name;
  final String description;
  OrderUpdateEvent({
    required this.id,
    required this.name,
    required this.description,
  });
}

class OrderViewWithComponentEvent extends OrderEvent {
  final String id;
  OrderViewWithComponentEvent({required this.id});
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

  ComponentOrderCreateEvent(
      {required this.name,
      required this.material,
      required this.height,
      required this.length,
      required this.quantity,
      required this.weightPerCubMeter,
      required this.width,
      required this.pricePerCubMeter});
}
