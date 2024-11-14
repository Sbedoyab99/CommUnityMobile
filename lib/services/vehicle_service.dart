import 'dart:convert';
import 'package:community/models/Vehicle.dart';
import 'package:http/http.dart' as http;

class VehicleService {
  final String apiUrl = 'https://communitybackend.azurewebsites.net/api/vehicles';

  Future<List<Vehicle>> fetchVehicles(String token, num apartmentId) async {
    final response = await http.get(
      Uri.parse('$apiUrl?$apartmentId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> vehiclesJson = jsonDecode(response.body);
      return vehiclesJson.map((json) => Vehicle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Vehicles');
    }
  }
}