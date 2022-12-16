
abstract class MaterialEvent {

  const MaterialEvent();
}

class MaterialLoadingEvent extends MaterialEvent {}

class MaterialViewByIdEvent extends MaterialEvent {
  final String idMaterial;

  const MaterialViewByIdEvent({
    required this.idMaterial,
  });
}

class MaterialCreateEvent extends MaterialEvent {
  final String name;
  final double weightPerCubMeter;
  final double pricePerCubMeter;

  const MaterialCreateEvent({
    required this.name,
    required this.weightPerCubMeter,
    required this.pricePerCubMeter,
  });
}

class MaterialUpdateEvent extends MaterialEvent{
  final String idMaterial;
  final String name;
  final double weightPerCubMeter;
  final double pricePerCubMeter;

  const MaterialUpdateEvent({
    required this.idMaterial,
    required this.name,
    required this.weightPerCubMeter,
    required this.pricePerCubMeter,
  });
}

class MaterialDeleteEvent extends MaterialEvent{
  final String idMaterial;

  const MaterialDeleteEvent({
    required this.idMaterial,
  });
}

