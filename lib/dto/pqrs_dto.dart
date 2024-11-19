class PqrsDTO {
  final num? id;
  final DateTime dateTime;
  final num? type;
  final String? content;
  final num? status;
  final num? apartmentId;
  final num? residentialUnitId;
  final String? observation;

  const PqrsDTO({
    this.id,
    required this.dateTime,
    this.type,
    this.content,
    this.status,
    this.apartmentId,
    this.residentialUnitId,
    this.observation,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['DateTime'] = dateTime.toIso8601String();
    map['Type'] = type;
    map['Content'] = content;
    map['Status'] = status;
    map['ApartmentId'] = apartmentId;
    map['ResidentialUnitId'] = residentialUnitId;
    map['Observation'] = observation;
    return map;
  }
}
