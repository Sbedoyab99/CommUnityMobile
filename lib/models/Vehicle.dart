import 'dart:convert';
/// id : 1
/// plate : "SGM688"
/// type : "Camioneta"
/// description : "Vehiculo tipo Camioneta de color Rojo"
/// apartmentId : 1

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));
String vehicleToJson(Vehicle data) => json.encode(data.toJson());
class Vehicle {
  Vehicle({
      num? id, 
      String? plate, 
      String? type, 
      String? description, 
      num? apartmentId,}){
    _id = id;
    _plate = plate;
    _type = type;
    _description = description;
    _apartmentId = apartmentId;
}

  Vehicle.fromJson(dynamic json) {
    _id = json['id'];
    _plate = json['plate'];
    _type = json['type'];
    _description = json['description'];
    _apartmentId = json['apartmentId'];
  }
  num? _id;
  String? _plate;
  String? _type;
  String? _description;
  num? _apartmentId;
Vehicle copyWith({  num? id,
  String? plate,
  String? type,
  String? description,
  num? apartmentId,
}) => Vehicle(  id: id ?? _id,
  plate: plate ?? _plate,
  type: type ?? _type,
  description: description ?? _description,
  apartmentId: apartmentId ?? _apartmentId,
);
  num? get id => _id;
  String? get plate => _plate;
  String? get type => _type;
  String? get description => _description;
  num? get apartmentId => _apartmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['plate'] = _plate;
    map['type'] = _type;
    map['description'] = _description;
    map['apartmentId'] = _apartmentId;
    return map;
  }

}