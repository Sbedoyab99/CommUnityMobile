import 'dart:convert';
import 'package:community/dto/user_dto.dart';
import 'package:community/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _baseUrl = "https://community-back-end.azurewebsites.net//api";

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(Uri.parse('$_baseUrl/accounts/Login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        String token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);

        return token;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> logOut() async {
    print('Aqui estoy!!!!!!!!!!!!!');
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('authToken');
      print('Supuestamente cerre sesion');
    } catch (e) {
      print(e);
    }
  }

  Future<User?> getUser(String token) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/accounts'),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final User user = User.fromJson(data);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> editUser(User? user, String token) async {
    final UserDTO userdto = UserDTO(
        FirstName: user!.firstName,
        LastName: user.lastName,
        PhoneNumber: user.phoneNumber,
        Address: user.address,
        Document: user.document,
        CityId: user.cityId,
        ResidentialUnitId: user.residentialUnitId,
        ApartmentId: user.apartmentId,
        UserType: user.userType);
    final response = await http.put(Uri.parse('$_baseUrl/accounts'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(userdto));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
