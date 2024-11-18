import 'dart:convert';

enum VisitorStatus { Pending, Approved, Rejected }

class VisitorEntryDTO {
  final num? id;
  final String name;
  final String? plate;
  final DateTime date;
  final num status;
  final num apartmentId;

  const VisitorEntryDTO({
    this.id,
    required this.name,
    this.plate,
    required this.date,
    required this.status,
    required this.apartmentId,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['Name'] = name;
    map['Plate'] = plate;
    map['Date'] = date.toIso8601String();
    map['Status'] = status;
    map['ApartmentId'] = apartmentId;
    return map;
  }

  factory VisitorEntryDTO.fromJson(Map<String, dynamic> json) {
    return VisitorEntryDTO(
      id: json['Id'],
      name: json['Name'],
      plate: json['Plate'],
      date: DateTime.parse(json['Date']),
      status: json['Status'],
      apartmentId: json['ApartmentId'],
    );
  }
}
