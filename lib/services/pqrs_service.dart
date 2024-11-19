import 'package:community/models/Pqrs.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../dto/pqrs_dto.dart';

class PqrsService {
  final String apiUrl = 'https://communitybackend.azurewebsites.net/api/Pqrss';

  Future<List<Pqrs>> fetchMail(String token, num residentialUnitId, String type,
      String status, num apartmentId,
      {int page = 1}) async {
    final response = await http.get(
      Uri.parse(
          '$apiUrl/pqrss?ResidentialUnitId=$residentialUnitId&type=$type&status=$status&page=$page&recordsnumber=5&ApartmentId=$apartmentId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> mailsJson = jsonDecode(response.body);
      return mailsJson.map((json) => Pqrs.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to load mails');
    }
  }

  Future<bool> createPqrs(String? token, PqrsDTO pqrsDTO) async {
    final response = await http.post(Uri.parse('$apiUrl/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(pqrsDTO));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
