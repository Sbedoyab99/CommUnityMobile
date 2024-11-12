/// document : "1039475784"
/// firstName : "Santiago"
/// lastName : "Bedoya"
/// address : "Cra 46 76 sur 69"
/// photo : null
/// userType : 3
/// cityId : 1
/// fullName : "Santiago Bedoya"
/// residentialUnit : {"id":1,"name":"Cyprus","address":"Cra 46 76 sur 69","cityId":1,"apartments":[{"id":1,"number":"101"}]}
/// residentialUnitId : 1
/// apartment : {"id":1,"number":"101","residentialUnitId":1}
/// apartmentId : 1
/// id : "a58685d3-74f1-41cd-b173-96090d15b8f1"
/// userName : "santiago@yopmail.com"
/// normalizedUserName : "SANTIAGO@YOPMAIL.COM"
/// email : "santiago@yopmail.com"
/// normalizedEmail : "SANTIAGO@YOPMAIL.COM"
/// emailConfirmed : true
/// passwordHash : "AQAAAAIAAYagAAAAEJbnukh9PbJVRw+hg4GowKjGzDyw2fo4EdF5bNUD/1cAMXav3x5ZWaizfnIb5QGi1g=="
/// securityStamp : "J4Y4G22X6OX7LLQSWWCKDMQ26MEBM5H4"
/// concurrencyStamp : "21b061df-a197-40b9-9408-dd16002e010b"
/// phoneNumber : "3205533944"
/// phoneNumberConfirmed : false
/// twoFactorEnabled : false
/// lockoutEnd : null
/// lockoutEnabled : true
/// accessFailedCount : 0

class User {
  User({
      String? document, 
      String? firstName, 
      String? lastName, 
      String? address, 
      dynamic photo, 
      num? userType, 
      num? cityId, 
      String? fullName, 
      ResidentialUnit? residentialUnit, 
      num? residentialUnitId, 
      Apartment? apartment, 
      num? apartmentId, 
      String? id, 
      String? userName, 
      String? normalizedUserName, 
      String? email, 
      String? normalizedEmail, 
      bool? emailConfirmed, 
      String? passwordHash, 
      String? securityStamp, 
      String? concurrencyStamp, 
      String? phoneNumber, 
      bool? phoneNumberConfirmed, 
      bool? twoFactorEnabled, 
      dynamic lockoutEnd, 
      bool? lockoutEnabled, 
      num? accessFailedCount,}){
    _document = document;
    _firstName = firstName;
    _lastName = lastName;
    _address = address;
    _photo = photo;
    _userType = userType;
    _cityId = cityId;
    _fullName = fullName;
    _residentialUnit = residentialUnit;
    _residentialUnitId = residentialUnitId;
    _apartment = apartment;
    _apartmentId = apartmentId;
    _id = id;
    _userName = userName;
    _normalizedUserName = normalizedUserName;
    _email = email;
    _normalizedEmail = normalizedEmail;
    _emailConfirmed = emailConfirmed;
    _passwordHash = passwordHash;
    _securityStamp = securityStamp;
    _concurrencyStamp = concurrencyStamp;
    _phoneNumber = phoneNumber;
    _phoneNumberConfirmed = phoneNumberConfirmed;
    _twoFactorEnabled = twoFactorEnabled;
    _lockoutEnd = lockoutEnd;
    _lockoutEnabled = lockoutEnabled;
    _accessFailedCount = accessFailedCount;
}

  User.fromJson(dynamic json) {
    _document = json['document'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _address = json['address'];
    _photo = json['photo'];
    _userType = json['userType'];
    _cityId = json['cityId'];
    _fullName = json['fullName'];
    _residentialUnit = json['residentialUnit'] != null ? ResidentialUnit.fromJson(json['residentialUnit']) : null;
    _residentialUnitId = json['residentialUnitId'];
    _apartment = json['apartment'] != null ? Apartment.fromJson(json['apartment']) : null;
    _apartmentId = json['apartmentId'];
    _id = json['id'];
    _userName = json['userName'];
    _normalizedUserName = json['normalizedUserName'];
    _email = json['email'];
    _normalizedEmail = json['normalizedEmail'];
    _emailConfirmed = json['emailConfirmed'];
    _passwordHash = json['passwordHash'];
    _securityStamp = json['securityStamp'];
    _concurrencyStamp = json['concurrencyStamp'];
    _phoneNumber = json['phoneNumber'];
    _phoneNumberConfirmed = json['phoneNumberConfirmed'];
    _twoFactorEnabled = json['twoFactorEnabled'];
    _lockoutEnd = json['lockoutEnd'];
    _lockoutEnabled = json['lockoutEnabled'];
    _accessFailedCount = json['accessFailedCount'];
  }
  String? _document;
  String? _firstName;
  String? _lastName;
  String? _address;
  dynamic _photo;
  num? _userType;
  num? _cityId;
  String? _fullName;
  ResidentialUnit? _residentialUnit;
  num? _residentialUnitId;
  Apartment? _apartment;
  num? _apartmentId;
  String? _id;
  String? _userName;
  String? _normalizedUserName;
  String? _email;
  String? _normalizedEmail;
  bool? _emailConfirmed;
  String? _passwordHash;
  String? _securityStamp;
  String? _concurrencyStamp;
  String? _phoneNumber;
  bool? _phoneNumberConfirmed;
  bool? _twoFactorEnabled;
  dynamic _lockoutEnd;
  bool? _lockoutEnabled;
  num? _accessFailedCount;
User copyWith({  String? document,
  String? firstName,
  String? lastName,
  String? address,
  dynamic photo,
  num? userType,
  num? cityId,
  String? fullName,
  ResidentialUnit? residentialUnit,
  num? residentialUnitId,
  Apartment? apartment,
  num? apartmentId,
  String? id,
  String? userName,
  String? normalizedUserName,
  String? email,
  String? normalizedEmail,
  bool? emailConfirmed,
  String? passwordHash,
  String? securityStamp,
  String? concurrencyStamp,
  String? phoneNumber,
  bool? phoneNumberConfirmed,
  bool? twoFactorEnabled,
  dynamic lockoutEnd,
  bool? lockoutEnabled,
  num? accessFailedCount,
}) => User(  document: document ?? _document,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  address: address ?? _address,
  photo: photo ?? _photo,
  userType: userType ?? _userType,
  cityId: cityId ?? _cityId,
  fullName: fullName ?? _fullName,
  residentialUnit: residentialUnit ?? _residentialUnit,
  residentialUnitId: residentialUnitId ?? _residentialUnitId,
  apartment: apartment ?? _apartment,
  apartmentId: apartmentId ?? _apartmentId,
  id: id ?? _id,
  userName: userName ?? _userName,
  normalizedUserName: normalizedUserName ?? _normalizedUserName,
  email: email ?? _email,
  normalizedEmail: normalizedEmail ?? _normalizedEmail,
  emailConfirmed: emailConfirmed ?? _emailConfirmed,
  passwordHash: passwordHash ?? _passwordHash,
  securityStamp: securityStamp ?? _securityStamp,
  concurrencyStamp: concurrencyStamp ?? _concurrencyStamp,
  phoneNumber: phoneNumber ?? _phoneNumber,
  phoneNumberConfirmed: phoneNumberConfirmed ?? _phoneNumberConfirmed,
  twoFactorEnabled: twoFactorEnabled ?? _twoFactorEnabled,
  lockoutEnd: lockoutEnd ?? _lockoutEnd,
  lockoutEnabled: lockoutEnabled ?? _lockoutEnabled,
  accessFailedCount: accessFailedCount ?? _accessFailedCount,
);
  String? get document => _document;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get address => _address;
  dynamic get photo => _photo;
  num? get userType => _userType;
  num? get cityId => _cityId;
  String? get fullName => _fullName;
  ResidentialUnit? get residentialUnit => _residentialUnit;
  num? get residentialUnitId => _residentialUnitId;
  Apartment? get apartment => _apartment;
  num? get apartmentId => _apartmentId;
  String? get id => _id;
  String? get userName => _userName;
  String? get normalizedUserName => _normalizedUserName;
  String? get email => _email;
  String? get normalizedEmail => _normalizedEmail;
  bool? get emailConfirmed => _emailConfirmed;
  String? get passwordHash => _passwordHash;
  String? get securityStamp => _securityStamp;
  String? get concurrencyStamp => _concurrencyStamp;
  String? get phoneNumber => _phoneNumber;
  bool? get phoneNumberConfirmed => _phoneNumberConfirmed;
  bool? get twoFactorEnabled => _twoFactorEnabled;
  dynamic get lockoutEnd => _lockoutEnd;
  bool? get lockoutEnabled => _lockoutEnabled;
  num? get accessFailedCount => _accessFailedCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['document'] = _document;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['address'] = _address;
    map['photo'] = _photo;
    map['userType'] = _userType;
    map['cityId'] = _cityId;
    map['fullName'] = _fullName;
    if (_residentialUnit != null) {
      map['residentialUnit'] = _residentialUnit?.toJson();
    }
    map['residentialUnitId'] = _residentialUnitId;
    if (_apartment != null) {
      map['apartment'] = _apartment?.toJson();
    }
    map['apartmentId'] = _apartmentId;
    map['id'] = _id;
    map['userName'] = _userName;
    map['normalizedUserName'] = _normalizedUserName;
    map['email'] = _email;
    map['normalizedEmail'] = _normalizedEmail;
    map['emailConfirmed'] = _emailConfirmed;
    map['passwordHash'] = _passwordHash;
    map['securityStamp'] = _securityStamp;
    map['concurrencyStamp'] = _concurrencyStamp;
    map['phoneNumber'] = _phoneNumber;
    map['phoneNumberConfirmed'] = _phoneNumberConfirmed;
    map['twoFactorEnabled'] = _twoFactorEnabled;
    map['lockoutEnd'] = _lockoutEnd;
    map['lockoutEnabled'] = _lockoutEnabled;
    map['accessFailedCount'] = _accessFailedCount;
    return map;
  }

}

/// id : 1
/// number : "101"
/// residentialUnitId : 1

class Apartment {
  Apartment({
      num? id, 
      String? number, 
      num? residentialUnitId,}){
    _id = id;
    _number = number;
    _residentialUnitId = residentialUnitId;
}

  Apartment.fromJson(dynamic json) {
    _id = json['id'];
    _number = json['number'];
    _residentialUnitId = json['residentialUnitId'];
  }
  num? _id;
  String? _number;
  num? _residentialUnitId;
Apartment copyWith({  num? id,
  String? number,
  num? residentialUnitId,
}) => Apartment(  id: id ?? _id,
  number: number ?? _number,
  residentialUnitId: residentialUnitId ?? _residentialUnitId,
);
  num? get id => _id;
  String? get number => _number;
  num? get residentialUnitId => _residentialUnitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['number'] = _number;
    map['residentialUnitId'] = _residentialUnitId;
    return map;
  }

}

/// id : 1
/// name : "Cyprus"
/// address : "Cra 46 76 sur 69"
/// cityId : 1
/// apartments : [{"id":1,"number":"101"}]

class ResidentialUnit {
  ResidentialUnit({
      num? id, 
      String? name, 
      String? address, 
      num? cityId, 
      List<Apartments>? apartments,}){
    _id = id;
    _name = name;
    _address = address;
    _cityId = cityId;
    _apartments = apartments;
}

  ResidentialUnit.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _address = json['address'];
    _cityId = json['cityId'];
    if (json['apartments'] != null) {
      _apartments = [];
      json['apartments'].forEach((v) {
        _apartments?.add(Apartments.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  String? _address;
  num? _cityId;
  List<Apartments>? _apartments;
ResidentialUnit copyWith({  num? id,
  String? name,
  String? address,
  num? cityId,
  List<Apartments>? apartments,
}) => ResidentialUnit(  id: id ?? _id,
  name: name ?? _name,
  address: address ?? _address,
  cityId: cityId ?? _cityId,
  apartments: apartments ?? _apartments,
);
  num? get id => _id;
  String? get name => _name;
  String? get address => _address;
  num? get cityId => _cityId;
  List<Apartments>? get apartments => _apartments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['address'] = _address;
    map['cityId'] = _cityId;
    if (_apartments != null) {
      map['apartments'] = _apartments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// number : "101"

class Apartments {
  Apartments({
      num? id, 
      String? number,}){
    _id = id;
    _number = number;
}

  Apartments.fromJson(dynamic json) {
    _id = json['id'];
    _number = json['number'];
  }
  num? _id;
  String? _number;
Apartments copyWith({  num? id,
  String? number,
}) => Apartments(  id: id ?? _id,
  number: number ?? _number,
);
  num? get id => _id;
  String? get number => _number;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['number'] = _number;
    return map;
  }

}