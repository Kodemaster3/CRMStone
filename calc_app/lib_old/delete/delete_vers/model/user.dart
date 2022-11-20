import 'dart:convert';

class User {
  final String id;
  final int count;

  User({
    required this.id,
    required this.count,
  });

  User copyWith({
    String? id,
    int? count,
  }) {
    return User(
      id: id ?? this.id,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'count': count,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      count: map['count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(id: $id, count: $count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.count == count;
  }

  @override
  int get hashCode => id.hashCode ^ count.hashCode;
}
