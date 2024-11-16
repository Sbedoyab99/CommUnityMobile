import 'dart:convert';
/// id : 1
/// number : "101"
/// residentialUnitId : 1
/// vehicles : null
/// vehiclesNumber : 0
/// pets : null
/// petsNumber : 0
/// users : null
/// usersNumber : 0
/// events : null
/// eventsNumber : 0
/// pqrss : null
/// pqrsNumber : 0

Apartment apartmentFromJson(String str) => Apartment.fromJson(json.decode(str));
String apartmentToJson(Apartment data) => json.encode(data.toJson());
class Apartment {
  Apartment({
      num? id, 
      String? number, 
      num? residentialUnitId, 
      dynamic vehicles, 
      num? vehiclesNumber, 
      dynamic pets, 
      num? petsNumber, 
      dynamic users, 
      num? usersNumber, 
      dynamic events, 
      num? eventsNumber, 
      dynamic pqrss, 
      num? pqrsNumber,}){
    _id = id;
    _number = number;
    _residentialUnitId = residentialUnitId;
    _vehicles = vehicles;
    _vehiclesNumber = vehiclesNumber;
    _pets = pets;
    _petsNumber = petsNumber;
    _users = users;
    _usersNumber = usersNumber;
    _events = events;
    _eventsNumber = eventsNumber;
    _pqrss = pqrss;
    _pqrsNumber = pqrsNumber;
}

  Apartment.fromJson(dynamic json) {
    _id = json['id'];
    _number = json['number'];
    _residentialUnitId = json['residentialUnitId'];
    _vehicles = json['vehicles'];
    _vehiclesNumber = json['vehiclesNumber'];
    _pets = json['pets'];
    _petsNumber = json['petsNumber'];
    _users = json['users'];
    _usersNumber = json['usersNumber'];
    _events = json['events'];
    _eventsNumber = json['eventsNumber'];
    _pqrss = json['pqrss'];
    _pqrsNumber = json['pqrsNumber'];
  }
  num? _id;
  String? _number;
  num? _residentialUnitId;
  dynamic _vehicles;
  num? _vehiclesNumber;
  dynamic _pets;
  num? _petsNumber;
  dynamic _users;
  num? _usersNumber;
  dynamic _events;
  num? _eventsNumber;
  dynamic _pqrss;
  num? _pqrsNumber;
Apartment copyWith({  num? id,
  String? number,
  num? residentialUnitId,
  dynamic vehicles,
  num? vehiclesNumber,
  dynamic pets,
  num? petsNumber,
  dynamic users,
  num? usersNumber,
  dynamic events,
  num? eventsNumber,
  dynamic pqrss,
  num? pqrsNumber,
}) => Apartment(  id: id ?? _id,
  number: number ?? _number,
  residentialUnitId: residentialUnitId ?? _residentialUnitId,
  vehicles: vehicles ?? _vehicles,
  vehiclesNumber: vehiclesNumber ?? _vehiclesNumber,
  pets: pets ?? _pets,
  petsNumber: petsNumber ?? _petsNumber,
  users: users ?? _users,
  usersNumber: usersNumber ?? _usersNumber,
  events: events ?? _events,
  eventsNumber: eventsNumber ?? _eventsNumber,
  pqrss: pqrss ?? _pqrss,
  pqrsNumber: pqrsNumber ?? _pqrsNumber,
);
  num? get id => _id;
  String? get number => _number;
  num? get residentialUnitId => _residentialUnitId;
  dynamic get vehicles => _vehicles;
  num? get vehiclesNumber => _vehiclesNumber;
  dynamic get pets => _pets;
  num? get petsNumber => _petsNumber;
  dynamic get users => _users;
  num? get usersNumber => _usersNumber;
  dynamic get events => _events;
  num? get eventsNumber => _eventsNumber;
  dynamic get pqrss => _pqrss;
  num? get pqrsNumber => _pqrsNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['number'] = _number;
    map['residentialUnitId'] = _residentialUnitId;
    map['vehicles'] = _vehicles;
    map['vehiclesNumber'] = _vehiclesNumber;
    map['pets'] = _pets;
    map['petsNumber'] = _petsNumber;
    map['users'] = _users;
    map['usersNumber'] = _usersNumber;
    map['events'] = _events;
    map['eventsNumber'] = _eventsNumber;
    map['pqrss'] = _pqrss;
    map['pqrsNumber'] = _pqrsNumber;
    return map;
  }

}