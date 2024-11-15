import 'dart:convert';

class VehicleDTO {
  final num? id;
  final String? plate;
  final String? type;
  final String? description;
  final num? apartmentId;

  const VehicleDTO({
    this.id,
    this.plate,
    this.type,
    this.description,
    this.apartmentId
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Plate'] = plate;
    map['type'] = type;
    map['Description'] = description;
    map['ApartmentId'] = apartmentId;
    return map;
  }

  String vehicleToJson(VehicleDTO data) => json.encode(data.toJson());
}