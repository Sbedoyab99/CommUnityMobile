import 'dart:convert';

class MailDTO {
  final num? id;
  final String? Sender;
  final String? Type;
  final num? Status;
  final num? ApartmentId;

  const MailDTO({
    this.id,
    this.Sender,
    this.Type,
    this.Status,
    this.ApartmentId
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Sender'] = Sender;
    map['Type'] = Type;
    map['Status'] = Status;
    map['ApartmentId'] = ApartmentId;
    return map;
  }

  /*@override
  String toString() {
    return 'MailDTO(id: $id, Sender: $Sender, Type: $Type, Status: $Status, ApartmentId: $ApartmentId)';
  }*/

}