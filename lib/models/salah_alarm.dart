import 'dart:convert';

class SalahAlarm {
  final int id;
  final String titleEn;
  final DateTime date;
  SalahAlarm({
    required this.id,
    required this.titleEn,
    required this.date,
  });

  SalahAlarm copyWith({
    int? id,
    String? titleEn,
    String? titleBn,
    bool? isAzan,
    bool? isEnglish,
    DateTime? date,
  }) {
    return SalahAlarm(
      id: id ?? this.id,
      titleEn: titleEn ?? this.titleEn,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titleEn': titleEn,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory SalahAlarm.fromMap(Map<String, dynamic> map) {
    return SalahAlarm(
      id: map['id'] as int,
      titleEn: map['titleEn'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory SalahAlarm.fromJson(String source) =>
      SalahAlarm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SalahAlarm(id: $id, titleEn: $titleEn, date: $date)';
  }

  @override
  bool operator ==(covariant SalahAlarm other) {
    if (identical(this, other)) return true;

    return other.id == id && other.titleEn == titleEn && other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ titleEn.hashCode ^ date.hashCode;
  }
}
