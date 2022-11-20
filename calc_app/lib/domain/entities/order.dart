import 'component.dart';

class OrderEntity {
  final String id;
  final String name;
  final String description;
  final List<ComponentEntity> component;

  OrderEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.component,
  });
}

  /* implement int repo

  String get nameDeliver {
    return id;
  }

  @override
  String toString() => 'Deliver(id: $id, nomenclature: $nomenclature)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomenclature': nomenclature.map((x) => x.toMap()).toList(),
    };
  }

  factory Deliver.fromMap(Map<String, dynamic> map) {
    return Deliver(
      id: map['id'] ?? '',
      nomenclature: List<Nomenclature>.from(
          map['nomenclature']?.map((x) => Nomenclature.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Deliver.fromJson(String source) =>
      Deliver.fromMap(json.decode(source));

  Deliver copyWith({
    String? id,
    List<Nomenclature>? nomenclature,
  }) {
    return Deliver(
      id: id ?? this.id,
      nomenclature: nomenclature ?? this.nomenclature,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Deliver &&
        other.id == id &&
        listEquals(other.nomenclature, nomenclature);
  }

  @override
  int get hashCode => id.hashCode ^ nomenclature.hashCode;

  */
// }


/*

class Deliver {
  final String id;
  final List<Nomenclature> nomenclature;
  final DateTime createDeliverDate = DateTime.now();
  final DateTime editTime;

  Deliver({
    required this.id,
    required this.nomenclature,
    required this.editTime,
  });

  String get nameDeliver {
    return id;
  }

  @override
  String toString() {
    return nameDeliver;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomenclature': nomenclature.map((x) => x.toMap()).toList(),
      'editTime': editTime.millisecondsSinceEpoch,
    };
  }

  factory Deliver.fromMap(Map<String, dynamic> map) {
    return Deliver(
      id: map['id'] ?? '',
      nomenclature: List<Nomenclature>.from(
          map['nomenclature']?.map((x) => Nomenclature.fromMap(x))),
      editTime: DateTime.fromMillisecondsSinceEpoch(map['editTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Deliver.fromJson(String source) =>
      Deliver.fromMap(json.decode(source));
}



 */