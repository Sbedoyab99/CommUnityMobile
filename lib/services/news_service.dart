import 'package:community/models/News.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class NewsService {
  final String apiUrl = 'https://communitybackend.azurewebsites.net/api/news';

  Future<List<News>> fetchNews(String token, num residentialUnitId) async {
    final response = await http.get(
      Uri.parse('$apiUrl?id=$residentialUnitId&page=1&recordsnumber=5'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> newsJson = jsonDecode(response.body);
      return newsJson.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
