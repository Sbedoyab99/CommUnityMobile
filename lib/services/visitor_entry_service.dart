import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dto/visitor_entry_dto.dart';
import '../models/VisitorEntry.dart';

class VisitorEntryService {
  final String apiUrl =
      'https://communitybackend.azurewebsites.net/api/VisitorEntry';

  Future<List<VisitorEntry>> fetchVisitorEntriesByApartment(
      String token, num apartmentId, String status,
      {int page = 1}) async {
    final response = await http.get(
      Uri.parse('$apiUrl/apartment/$apartmentId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> visitorsJson = jsonDecode(response.body);
      return visitorsJson.map((json) => VisitorEntry.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Visitor Entries by Apartment');
    }
  }

  Future<bool> cancelVisitorEntry(
      String token, VisitorEntryDTO visitorEntryDTO) async {
    final response = await http.put(
      Uri.parse('$apiUrl/cancel'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(visitorEntryDTO),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> scheduleVisitor(String token, VisitorEntryDTO visitorEntryDTO) async {
    final response = await http.post(
      Uri.parse('$apiUrl/schedule'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(visitorEntryDTO),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
