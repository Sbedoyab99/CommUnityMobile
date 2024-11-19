import 'dart:convert';
/// id : 1
/// dateTime : "2024-11-08T20:24:37.1362971"
/// pqrsType : 0
/// content : "Prueba Prueba Prueba "
/// pqrsState : 0
/// apartmentId : 0
/// apartment : {"id":2,"number":"102","residentialUnitId":0,"residentialUnit":null,"vehicles":null,"vehiclesNumber":0,"pets":null,"petsNumber":0,"users":null,"usersNumber":0,"events":null,"eventsNumber":0,"pqrss":null,"pqrsNumber":0}
/// residentialUnitId : 0
/// residentialUnit : {"id":1,"name":"Cyprus","address":null,"cityId":0,"city":null,"apartments":null,"apartmentsNumber":0,"commonZones":null,"commonZonesNumber":0,"news":null,"newsNumber":0,"users":null,"usersNumber":0,"events":null,"eventsNumber":0,"pqrss":null,"pqrsNumber":0,"hasAdmin":false}
/// pqrsMovements : null
/// pqrsMovementsNumber : 0

Pqrs pqrsFromJson(String str) => Pqrs.fromJson(json.decode(str));
String pqrsToJson(Pqrs data) => json.encode(data.toJson());
class Pqrs {
  Pqrs({
      num? id, 
      String? dateTime, 
      num? pqrsType, 
      String? content, 
      num? pqrsState, 
      num? apartmentId, 
      Apartment? apartment, 
      num? residentialUnitId, 
      ResidentialUnit? residentialUnit, 
      dynamic pqrsMovements, 
      num? pqrsMovementsNumber,}){
    _id = id;
    _dateTime = dateTime;
    _pqrsType = pqrsType;
    _content = content;
    _pqrsState = pqrsState;
    _apartmentId = apartmentId;
    _apartment = apartment;
    _residentialUnitId = residentialUnitId;
    _residentialUnit = residentialUnit;
    _pqrsMovements = pqrsMovements;
    _pqrsMovementsNumber = pqrsMovementsNumber;
}

  Pqrs.fromJson(dynamic json) {
    _id = json['id'];
    _dateTime = json['dateTime'];
    _pqrsType = json['pqrsType'];
    _content = json['content'];
    _pqrsState = json['pqrsState'];
    _apartmentId = json['apartmentId'];
    _apartment = json['apartment'] != null ? Apartment.fromJson(json['apartment']) : null;
    _residentialUnitId = json['residentialUnitId'];
    _residentialUnit = json['residentialUnit'] != null ? ResidentialUnit.fromJson(json['residentialUnit']) : null;
    _pqrsMovements = json['pqrsMovements'];
    _pqrsMovementsNumber = json['pqrsMovementsNumber'];
  }
  num? _id;
  String? _dateTime;
  num? _pqrsType;
  String? _content;
  num? _pqrsState;
  num? _apartmentId;
  Apartment? _apartment;
  num? _residentialUnitId;
  ResidentialUnit? _residentialUnit;
  dynamic _pqrsMovements;
  num? _pqrsMovementsNumber;
Pqrs copyWith({  num? id,
  String? dateTime,
  num? pqrsType,
  String? content,
  num? pqrsState,
  num? apartmentId,
  Apartment? apartment,
  num? residentialUnitId,
  ResidentialUnit? residentialUnit,
  dynamic pqrsMovements,
  num? pqrsMovementsNumber,
}) => Pqrs(  id: id ?? _id,
  dateTime: dateTime ?? _dateTime,
  pqrsType: pqrsType ?? _pqrsType,
  content: content ?? _content,
  pqrsState: pqrsState ?? _pqrsState,
  apartmentId: apartmentId ?? _apartmentId,
  apartment: apartment ?? _apartment,
  residentialUnitId: residentialUnitId ?? _residentialUnitId,
  residentialUnit: residentialUnit ?? _residentialUnit,
  pqrsMovements: pqrsMovements ?? _pqrsMovements,
  pqrsMovementsNumber: pqrsMovementsNumber ?? _pqrsMovementsNumber,
);
  num? get id => _id;
  String? get dateTime => _dateTime;
  num? get pqrsType => _pqrsType;
  String? get content => _content;
  num? get pqrsState => _pqrsState;
  num? get apartmentId => _apartmentId;
  Apartment? get apartment => _apartment;
  num? get residentialUnitId => _residentialUnitId;
  ResidentialUnit? get residentialUnit => _residentialUnit;
  dynamic get pqrsMovements => _pqrsMovements;
  num? get pqrsMovementsNumber => _pqrsMovementsNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['dateTime'] = _dateTime;
    map['pqrsType'] = _pqrsType;
    map['content'] = _content;
    map['pqrsState'] = _pqrsState;
    map['apartmentId'] = _apartmentId;
    if (_apartment != null) {
      map['apartment'] = _apartment?.toJson();
    }
    map['residentialUnitId'] = _residentialUnitId;
    if (_residentialUnit != null) {
      map['residentialUnit'] = _residentialUnit?.toJson();
    }
    map['pqrsMovements'] = _pqrsMovements;
    map['pqrsMovementsNumber'] = _pqrsMovementsNumber;
    return map;
  }

}

/// id : 1
/// name : "Cyprus"
/// address : null
/// cityId : 0
/// city : null
/// apartments : null
/// apartmentsNumber : 0
/// commonZones : null
/// commonZonesNumber : 0
/// news : null
/// newsNumber : 0
/// users : null
/// usersNumber : 0
/// events : null
/// eventsNumber : 0
/// pqrss : null
/// pqrsNumber : 0
/// hasAdmin : false

ResidentialUnit residentialUnitFromJson(String str) => ResidentialUnit.fromJson(json.decode(str));
String residentialUnitToJson(ResidentialUnit data) => json.encode(data.toJson());
class ResidentialUnit {
  ResidentialUnit({
      num? id, 
      String? name, 
      dynamic address, 
      num? cityId, 
      dynamic city, 
      dynamic apartments, 
      num? apartmentsNumber, 
      dynamic commonZones, 
      num? commonZonesNumber, 
      dynamic news, 
      num? newsNumber, 
      dynamic users, 
      num? usersNumber, 
      dynamic events, 
      num? eventsNumber, 
      dynamic pqrss, 
      num? pqrsNumber, 
      bool? hasAdmin,}){
    _id = id;
    _name = name;
    _address = address;
    _cityId = cityId;
    _city = city;
    _apartments = apartments;
    _apartmentsNumber = apartmentsNumber;
    _commonZones = commonZones;
    _commonZonesNumber = commonZonesNumber;
    _news = news;
    _newsNumber = newsNumber;
    _users = users;
    _usersNumber = usersNumber;
    _events = events;
    _eventsNumber = eventsNumber;
    _pqrss = pqrss;
    _pqrsNumber = pqrsNumber;
    _hasAdmin = hasAdmin;
}

  ResidentialUnit.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _cityId = json['cityId'];
    _city = json['city'];
    _apartments = json['apartments'];
    _apartmentsNumber = json['apartmentsNumber'];
    _commonZones = json['commonZones'];
    _commonZonesNumber = json['commonZonesNumber'];
    _news = json['news'];
    _newsNumber = json['newsNumber'];
    _users = json['users'];
    _usersNumber = json['usersNumber'];
    _events = json['events'];
    _eventsNumber = json['eventsNumber'];
    _pqrss = json['pqrss'];
    _pqrsNumber = json['pqrsNumber'];
    _hasAdmin = json['hasAdmin'];
  }
  num? _id;
  String? _name;
  dynamic _address;
  num? _cityId;
  dynamic _city;
  dynamic _apartments;
  num? _apartmentsNumber;
  dynamic _commonZones;
  num? _commonZonesNumber;
  dynamic _news;
  num? _newsNumber;
  dynamic _users;
  num? _usersNumber;
  dynamic _events;
  num? _eventsNumber;
  dynamic _pqrss;
  num? _pqrsNumber;
  bool? _hasAdmin;
ResidentialUnit copyWith({  num? id,
  String? name,
  dynamic address,
  num? cityId,
  dynamic city,
  dynamic apartments,
  num? apartmentsNumber,
  dynamic commonZones,
  num? commonZonesNumber,
  dynamic news,
  num? newsNumber,
  dynamic users,
  num? usersNumber,
  dynamic events,
  num? eventsNumber,
  dynamic pqrss,
  num? pqrsNumber,
  bool? hasAdmin,
}) => ResidentialUnit(  id: id ?? _id,
  name: name ?? _name,
  address: address ?? _address,
  cityId: cityId ?? _cityId,
  city: city ?? _city,
  apartments: apartments ?? _apartments,
  apartmentsNumber: apartmentsNumber ?? _apartmentsNumber,
  commonZones: commonZones ?? _commonZones,
  commonZonesNumber: commonZonesNumber ?? _commonZonesNumber,
  news: news ?? _news,
  newsNumber: newsNumber ?? _newsNumber,
  users: users ?? _users,
  usersNumber: usersNumber ?? _usersNumber,
  events: events ?? _events,
  eventsNumber: eventsNumber ?? _eventsNumber,
  pqrss: pqrss ?? _pqrss,
  pqrsNumber: pqrsNumber ?? _pqrsNumber,
  hasAdmin: hasAdmin ?? _hasAdmin,
);
  num? get id => _id;
  String? get name => _name;
  dynamic get address => _address;
  num? get cityId => _cityId;
  dynamic get city => _city;
  dynamic get apartments => _apartments;
  num? get apartmentsNumber => _apartmentsNumber;
  dynamic get commonZones => _commonZones;
  num? get commonZonesNumber => _commonZonesNumber;
  dynamic get news => _news;
  num? get newsNumber => _newsNumber;
  dynamic get users => _users;
  num? get usersNumber => _usersNumber;
  dynamic get events => _events;
  num? get eventsNumber => _eventsNumber;
  dynamic get pqrss => _pqrss;
  num? get pqrsNumber => _pqrsNumber;
  bool? get hasAdmin => _hasAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['cityId'] = _cityId;
    map['city'] = _city;
    map['apartments'] = _apartments;
    map['apartmentsNumber'] = _apartmentsNumber;
    map['commonZones'] = _commonZones;
    map['commonZonesNumber'] = _commonZonesNumber;
    map['news'] = _news;
    map['newsNumber'] = _newsNumber;
    map['users'] = _users;
    map['usersNumber'] = _usersNumber;
    map['events'] = _events;
    map['eventsNumber'] = _eventsNumber;
    map['pqrss'] = _pqrss;
    map['pqrsNumber'] = _pqrsNumber;
    map['hasAdmin'] = _hasAdmin;
    return map;
  }

}

/// id : 2
/// number : "102"
/// residentialUnitId : 0
/// residentialUnit : null
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
      dynamic residentialUnit, 
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
    _residentialUnit = residentialUnit;
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
    _residentialUnit = json['residentialUnit'];
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
  dynamic _residentialUnit;
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
  dynamic residentialUnit,
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
  residentialUnit: residentialUnit ?? _residentialUnit,
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
  dynamic get residentialUnit => _residentialUnit;
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
    map['residentialUnit'] = _residentialUnit;
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