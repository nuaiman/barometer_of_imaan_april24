// ignore_for_file: public_member_api_docs, sort_constructors_first
class Salah {
  final int id;
  final String nameEn;
  final String nameBn;
  final DateTime time;
  Salah({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    required this.time,
  });

  @override
  String toString() {
    return 'Salah(id: $id, nameEn: $nameEn, nameBn: $nameBn, time: $time)';
  }

  @override
  bool operator ==(covariant Salah other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nameEn == nameEn &&
        other.nameBn == nameBn &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nameEn.hashCode ^ nameBn.hashCode ^ time.hashCode;
  }

  Salah copyWith({
    int? id,
    String? nameEn,
    String? nameBn,
    DateTime? time,
  }) {
    return Salah(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      time: time ?? this.time,
    );
  }
}
