import 'dart:convert';
/// id : 1
/// name : "Bailey"
/// breed : "Bulldog"
/// picture : null
/// apartmentId : 1

Pet petFromJson(String str) => Pet.fromJson(json.decode(str));
String petToJson(Pet data) => json.encode(data.toJson());
class Pet {
  Pet({
      num? id, 
      String? name, 
      String? breed, 
      dynamic picture, 
      num? apartmentId,}){
    _id = id;
    _name = name;
    _breed = breed;
    _picture = picture;
    _apartmentId = apartmentId;
}

  Pet.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _breed = json['breed'];
    _picture = json['picture'];
    _apartmentId = json['apartmentId'];
  }
  num? _id;
  String? _name;
  String? _breed;
  dynamic _picture;
  num? _apartmentId;
Pet copyWith({  num? id,
  String? name,
  String? breed,
  dynamic picture,
  num? apartmentId,
}) => Pet(  id: id ?? _id,
  name: name ?? _name,
  breed: breed ?? _breed,
  picture: picture ?? _picture,
  apartmentId: apartmentId ?? _apartmentId,
);
  num? get id => _id;
  String? get name => _name;
  String? get breed => _breed;
  dynamic get picture => _picture;
  num? get apartmentId => _apartmentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['breed'] = _breed;
    map['picture'] = _picture;
    map['apartmentId'] = _apartmentId;
    return map;
  }

}