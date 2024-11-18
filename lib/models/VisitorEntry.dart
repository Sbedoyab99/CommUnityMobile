import 'dart:convert';
VisitorEntry visitorEntryFromJson(String str) => VisitorEntry.fromJson(json.decode(str));
String visitorEntryToJson(VisitorEntry data) => json.encode(data.toJson());

class VisitorEntry {
  VisitorEntry({
      String? name,
      String? plate,
      num? status,
      num? id,
      dynamic eventType,
      String? dateTime,
      dynamic residentialUnitId,
      ResidentialUnit? residentialUnit,
      dynamic apartmentId,
      Apartment? apartment,}){
    _name = name;
    _plate = plate;
    _status = status;
    _id = id;
    _eventType = eventType;
    _dateTime = dateTime;
    _residentialUnitId = residentialUnitId;
    _residentialUnit = residentialUnit;
    _apartmentId = apartmentId;
    _apartment = apartment;
}

  VisitorEntry.fromJson(dynamic json) {
    _name = json['name'];
    _plate = json['plate'];
    _status = json['status'];
    _id = json['id'];
    _eventType = json['eventType'];
    _dateTime = json['dateTime'];
    _residentialUnitId = json['residentialUnitId'];
    _residentialUnit = json['residentialUnit'] != null ? ResidentialUnit.fromJson(json['residentialUnit']) : null;
    _apartmentId = json['apartmentId'];
    _apartment = json['apartment'] != null ? Apartment.fromJson(json['apartment']) : null;
  }
  String? _name;
  String? _plate;
  num? _status;
  num? _id;
  dynamic _eventType;
  String? _dateTime;
  dynamic _residentialUnitId;
  ResidentialUnit? _residentialUnit;
  dynamic _apartmentId;
  Apartment? _apartment;
VisitorEntry copyWith({  String? name,
  String? plate,
  num? status,
  num? id,
  dynamic eventType,
  String? dateTime,
  dynamic residentialUnitId,
  ResidentialUnit? residentialUnit,
  dynamic apartmentId,
  Apartment? apartment,
}) => VisitorEntry(  name: name ?? _name,
  plate: plate ?? _plate,
  status: status ?? _status,
  id: id ?? _id,
  eventType: eventType ?? _eventType,
  dateTime: dateTime ?? _dateTime,
  residentialUnitId: residentialUnitId ?? _residentialUnitId,
  residentialUnit: residentialUnit ?? _residentialUnit,
  apartmentId: apartmentId ?? _apartmentId,
  apartment: apartment ?? _apartment,
);
  String? get name => _name;
  String? get plate => _plate;
  num? get status => _status;
  num? get id => _id;
  dynamic get eventType => _eventType;
  String? get dateTime => _dateTime;
  dynamic get residentialUnitId => _residentialUnitId;
  ResidentialUnit? get residentialUnit => _residentialUnit;
  dynamic get apartmentId => _apartmentId;
  Apartment? get apartment => _apartment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['plate'] = _plate;
    map['status'] = _status;
    map['id'] = _id;
    map['eventType'] = _eventType;
    map['dateTime'] = _dateTime;
    map['residentialUnitId'] = _residentialUnitId;
    if (_residentialUnit != null) {
      map['residentialUnit'] = _residentialUnit?.toJson();
    }
    map['apartmentId'] = _apartmentId;
    if (_apartment != null) {
      map['apartment'] = _apartment?.toJson();
    }
    return map;
  }

}

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