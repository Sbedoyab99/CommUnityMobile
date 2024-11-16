import 'dart:convert';

class UserDTO {
  final String? FirstName;
  final String? LastName;
  final String? PhoneNumber;
  final String? Document;
  final String? Address;
  final num? CityId;
  final num? ResidentialUnitId;
  final num? ApartmentId;
  final num? UserType;


  const UserDTO({
    this.FirstName,
    this.LastName,
    this.PhoneNumber,
    this.Document,
    this.Address,
    this.CityId,
    this.ResidentialUnitId,
    this.ApartmentId,
    this.UserType,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['FirstName'] = FirstName;
    map['LastName'] = LastName;
    map['PhoneNumber'] = PhoneNumber;
    map['Document'] = Document;
    map['Address'] = Address;
    map['CityId'] = CityId;
    map['ResidentialUnitId'] = ResidentialUnitId;
    map['ApartmentId'] = ApartmentId;
    map['UserType'] = UserType;
    map['Photo'] = '';
    return map;
  }

  String userToJson(UserDTO data) => json.encode(data.toJson());
}