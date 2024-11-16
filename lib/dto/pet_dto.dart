import 'dart:convert';

class PetDTO {
  final num? id;
  final String? Name;
  final String? Breed;
  final String? Picture;
  final num? ApartmentId;

  const PetDTO({
    this.id,
    this.Name,
    this.Breed,
    this.Picture,
    this.ApartmentId
});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Name'] = Name;
    map['Breed'] = Breed;
    map['Picture'] = Picture;
    map['ApartmentId'] = ApartmentId;
    return map;
  }

  String petToJson(PetDTO data) => json.encode(data.toJson());
}