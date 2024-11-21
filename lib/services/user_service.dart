import 'dart:convert';
import 'package:community/models/User.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String apiUrl = 'https://community-back-end.azurewebsites.net//api/resident';

  Future<List<User>> fetchUsers(String token, num apartmentId) async {
    final response = await http.get(
      Uri.parse('$apiUrl/resident?apartmentId=$apartmentId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> usersJson = jsonDecode(response.body);
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Pets');
    }
  }
}