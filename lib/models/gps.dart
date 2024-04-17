import 'dart:convert';

class GpsModel {
  final double latitude;
  final double longitude;
  final String street;
  final String locality;
  final String subAdministrativeArea;
  final String administrativeArea;
  final String country;
  final String isoCountryCode;
  GpsModel({
    required this.latitude,
    required this.longitude,
    required this.street,
    required this.locality,
    required this.subAdministrativeArea,
    required this.administrativeArea,
    required this.country,
    required this.isoCountryCode,
  });

  GpsModel copyWith({
    double? latitude,
    double? longitude,
    String? street,
    String? locality,
    String? subAdministrativeArea,
    String? administrativeArea,
    String? country,
    String? isoCountryCode,
  }) {
    return GpsModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      street: street ?? this.street,
      locality: locality ?? this.locality,
      subAdministrativeArea:
          subAdministrativeArea ?? this.subAdministrativeArea,
      administrativeArea: administrativeArea ?? this.administrativeArea,
      country: country ?? this.country,
      isoCountryCode: isoCountryCode ?? this.isoCountryCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'latitude': latitude});
    result.addAll({'longitude': longitude});
    result.addAll({'street': street});
    result.addAll({'locality': locality});
    result.addAll({'subAdministrativeArea': subAdministrativeArea});
    result.addAll({'administrativeArea': administrativeArea});
    result.addAll({'country': country});
    result.addAll({'isoCountryCode': isoCountryCode});

    return result;
  }

  factory GpsModel.fromMap(Map<String, dynamic> map) {
    return GpsModel(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      street: map['street'] ?? '',
      locality: map['locality'] ?? '',
      subAdministrativeArea: map['subAdministrativeArea'] ?? '',
      administrativeArea: map['administrativeArea'] ?? '',
      country: map['country'] ?? '',
      isoCountryCode: map['isoCountryCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory GpsModel.fromJson(String source) =>
      GpsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GpsModel(latitude: $latitude, longitude: $longitude, street: $street, locality: $locality, subAdministrativeArea: $subAdministrativeArea, administrativeArea: $administrativeArea, country: $country, isoCountryCode: $isoCountryCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GpsModel &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.street == street &&
        other.locality == locality &&
        other.subAdministrativeArea == subAdministrativeArea &&
        other.administrativeArea == administrativeArea &&
        other.country == country &&
        other.isoCountryCode == isoCountryCode;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        street.hashCode ^
        locality.hashCode ^
        subAdministrativeArea.hashCode ^
        administrativeArea.hashCode ^
        country.hashCode ^
        isoCountryCode.hashCode;
  }
}
