import 'dart:convert';
import 'package:community/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _baseUrl = "https://communitybackend.azurewebsites.net/api";
  
  Future<String?> login(String email, String password) async  {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/accounts/Login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password})
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        return token;
      } else {
        print('Error en el inicio de sesión: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error de red: $e');
      return null;
    }
  }

  Future<User?> getUser(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/accounts'),
        headers: {
          'Authorization': 'Bearer $token'
        }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final User user = User.fromJson(data);
        print(user.email);
        return user;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error de red: $e');
      return null;
    }
  }
}