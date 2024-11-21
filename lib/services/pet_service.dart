import 'dart:convert';

import 'package:community/dto/pet_dto.dart';
import 'package:community/models/Pet.dart';
import 'package:http/http.dart' as http;

class PetService {
  final String apiUrl = 'https://community-back-end.azurewebsites.net//api/pets';

  Future<List<Pet>> fetchPets(String token, num apartmentId) async {
    final response = await http.get(
      Uri.parse('$apiUrl?id=$apartmentId'),
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

  Future<bool> createPet(String? token, PetDTO petDTO) async {
    final response = await http.post(
      Uri.parse('$apiUrl/full'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(petDTO)
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> editPet(String? token, PetDTO petDTO) async {
    final response = await http.put(
        Uri.parse('$apiUrl/full'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(petDTO)
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> deletePet(String token, num petId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$petId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if(response.statusCode == 204) {
      return true;
    }
    return false;
  }
}