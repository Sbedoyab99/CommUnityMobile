import 'dart:convert';
import 'package:community/models/Apartment.dart';
import 'package:http/http.dart' as http;

class ApartmentService {
  final String apiUrl = 'https://community-back-end.azurewebsites.net/api/apartments';

  Future<Apartment> fetchApartment(String token, num apartmentId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/$apartmentId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      dynamic apartmentJson = jsonDecode(response.body);
      return Apartment.fromJson(apartmentJson);
    } else {
      throw Exception('Failed to load Apartment');
    }
  }
}
