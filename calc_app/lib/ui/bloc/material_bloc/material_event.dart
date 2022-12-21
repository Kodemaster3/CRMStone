abstract class MaterialEvent {
  const MaterialEvent();
}

class MaterialLoadingEvent extends MaterialEvent {}

class MaterialCreatingEvent extends MaterialEvent {}

class MaterialViewByIdEvent extends MaterialEvent {
  final String idMaterial;

  const MaterialViewByIdEvent({
    required this.idMaterial,
  });
}

class MaterialCreatedEvent extends MaterialEvent {
  final String name;
  final double weightPerCubMeter;
  final double pricePerCubMeter;

  const MaterialCreatedEvent({
    required this.name,
    required this.weightPerCubMeter,
    required this.pricePerCubMeter,
  });
}

class MaterialUpdatingEvent extends MaterialEvent {
  final String idMaterial;

  const MaterialUpdatingEvent({
    required this.idMaterial,
  });
}

class MaterialUpdateEvent extends MaterialEvent {
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

class MaterialDeleteEvent extends MaterialEvent {
  final String idMaterial;

  const MaterialDeleteEvent({
    required this.idMaterial,
  });
}

class MaterialSetIdEvent extends MaterialEvent {
  final String materialId;

  const MaterialSetIdEvent({
    required this.materialId,
  });
}
