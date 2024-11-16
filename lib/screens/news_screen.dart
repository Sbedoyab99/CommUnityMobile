import 'package:community/models/News.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (news.picture!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                news.picture!,
                fit: BoxFit.contain,
              ),
            ),
          const SizedBox(height: 20),
          Text(
            news.title!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            news.content!,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
