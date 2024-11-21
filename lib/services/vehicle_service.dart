import 'dart:convert';
import 'package:community/dto/vehicle_dto.dart';
import 'package:community/models/Vehicle.dart';
import 'package:http/http.dart' as http;

class VehicleService {
  final String apiUrl = 'https://community-back-end.azurewebsites.net//api/vehicles';

  Future<List<Vehicle>> fetchVehicles(String token, num apartmentId) async {
    final response = await http.get(
      Uri.parse('$apiUrl?id=$apartmentId'),
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

  Future<bool> createVehicle(String? token, VehicleDTO vehicleDTO) async {
    final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(vehicleDTO)
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> editVehicle(String? token, VehicleDTO vehicleDTO) async {
    final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(vehicleDTO)
    );
    if(response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> deleteVehicle(String token, num vehicleId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$vehicleId'),
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