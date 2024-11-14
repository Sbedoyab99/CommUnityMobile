import 'dart:convert';

import 'package:community/models/Pet.dart';
import 'package:http/http.dart' as http;

class PetService {
  final String apiUrl = 'https://communitybackend.azurewebsites.net/api/pets';

  Future<List<Pet>> fetchPets(String token, num apartmentId) async {
    final response = await http.get(
      Uri.parse('$apiUrl?$apartmentId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> petsJson = jsonDecode(response.body);
      return petsJson.map((json) => Pet.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Pets');
    }
  }
}