import 'package:community/models/News.dart';
import 'package:community/models/User.dart';
import 'package:community/screens/news_screen.dart';
import 'package:community/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:community/services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  String? token;
  User? user;
  List<News> news = [];

  final AuthService _authService = AuthService();
  final NewsService _newsService = NewsService();

  @override
  void initState() {
    super.initState();
    loadAsync();
  }

  Future<void> loadAsync() async {
    setState(() {
      isLoading = true;
    });
    token = await loadToken();
    user = await loadUser(token!);
    news = await loadNews(token!, user!.residentialUnitId!);
    setState(() {
      isLoading = false;
    });
  }

  Future<String?> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token != null) {
      return token;
    } else {
      return null;
    }
  }

  Future<User?> loadUser(String token) async {
    final user = await _authService.getUser(token);
    return user;
  }

  Future<List<News>> loadNews(String token, num id) async {
    final news = await _newsService.fetchNews(token, id);
    return news;
  }

  void viewNews(BuildContext context, News news) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(news.title!),
          content: NewsScreen(news: news),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RefreshIndicator(
                onRefresh: loadAsync,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    final newsItem = news[index];
                    return InkWell(
                      onTap: () {
                        viewNews(context, newsItem);
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            newsItem.picture != null
                                ? Image.network(
                                    newsItem.picture!,
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset(
                                    'assets/defaultImage.avif',
                                    fit: BoxFit.cover,
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                newsItem.title!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                newsItem.content!.characters
                                    .take(100)
                                    .toString(),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
  }
}
