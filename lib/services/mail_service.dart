import 'package:community/models/Mail.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:community/dto/mail_dto.dart';

class MailService {
  final String apiUrl = 'https://community-back-end.azurewebsites.net/api/mail';

  Future<List<Mail>> fetchMail(
      String token, num apartmentId, String status, {int page = 1}) async {

    final response = await http.get(
      Uri.parse(
          '$apiUrl/MailApartmentStatus?id=$apartmentId&status=$status&page=$page&recordsnumber=5'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> mailsJson = jsonDecode(response.body);
      return mailsJson.map((json) => Mail.fromJson(json)).toList();
    } else {
      print('Error: ${response.statusCode}');
      throw Exception('Failed to load mails');
    }
  }

  Future<bool> editMail(String? token, MailDTO mailDTO) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/updateStatus'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(mailDTO),
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error: ${e}');
      return false;
    }
  }
}
