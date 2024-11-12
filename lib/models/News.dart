/// id : 1
/// title : "Nueva Aplicacion"
/// content : "Nos hemos registrado en la nueva aplicacion CommUnity"
/// date : "2024-11-02T18:04:12.6233333"
/// picture : "https://community2024.blob.core.windows.net/products/b72b4081-5c7f-442b-ab3d-a28751d72492.jpg"
/// residentialUnitId : 1

class News {
  News({
      num? id, 
      String? title, 
      String? content, 
      String? date, 
      String? picture, 
      num? residentialUnitId,}){
    _id = id;
    _title = title;
    _content = content;
    _date = date;
    _picture = picture;
    _residentialUnitId = residentialUnitId;
}

  News.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _content = json['content'];
    _date = json['date'];
    _picture = json['picture'];
    _residentialUnitId = json['residentialUnitId'];
  }
  num? _id;
  String? _title;
  String? _content;
  String? _date;
  String? _picture;
  num? _residentialUnitId;
News copyWith({  num? id,
  String? title,
  String? content,
  String? date,
  String? picture,
  num? residentialUnitId,
}) => News(  id: id ?? _id,
  title: title ?? _title,
  content: content ?? _content,
  date: date ?? _date,
  picture: picture ?? _picture,
  residentialUnitId: residentialUnitId ?? _residentialUnitId,
);
  num? get id => _id;
  String? get title => _title;
  String? get content => _content;
  String? get date => _date;
  String? get picture => _picture;
  num? get residentialUnitId => _residentialUnitId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['content'] = _content;
    map['date'] = _date;
    map['picture'] = _picture;
    map['residentialUnitId'] = _residentialUnitId;
    return map;
  }

}