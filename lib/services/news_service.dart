import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  static const String _apiKey =
      '80ee63dfe0c647cd9db15decb8f98e4a'; // Replace with your key
  static const String _baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchTrendingNews({
    String category = 'general',
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$_baseUrl/top-headlines?country=us&category=$category&apiKey=$_apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];

        return articles
            .where(
              (json) => json['title'] != null && json['urlToImage'] != null,
            )
            .map((json) {
              return NewsArticle(
                id: json['url'] ?? DateTime.now().toString(), // Use URL as ID
                title: json['title'] ?? 'No Title',
                description: json['description'] ?? 'No description available.',
                imageUrl:
                    json['urlToImage'] ?? 'https://via.placeholder.com/800x400',
                source: json['source']['name'] ?? 'Unknown Source',
                publishedAt: DateTime.parse(json['publishedAt']),
                category: category, // Use the requested category
                viralScore: (50 + (json['title'].length % 50))
                    .toDouble(), // Mock viral score
                videoUrl: null, // NewsAPI doesn't provide video URLs directly
              );
            })
            .toList();
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
      return _getMockNews(); // Fallback to mock data
    }
  }

  // Mock data for fallback
  List<NewsArticle> _getMockNews() {
    return [
      NewsArticle(
        id: '1',
        title: 'SpaceX Successfully Launches Starship to Orbit',
        description:
            'The massive rocket achieved orbit for the first time, marking a new era in space exploration.',
        imageUrl:
            'https://images.unsplash.com/photo-1517976487492-5750f3195933?w=800&q=80',
        source: 'Space News',
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
        category: 'Technology',
        viralScore: 95.0,
        videoUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
      NewsArticle(
        id: '2',
        title: 'Global AI Summit Reaches Historic Agreement',
        description:
            'World leaders agree on new safety protocols for artificial intelligence development.',
        imageUrl:
            'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=800&q=80',
        source: 'Tech Daily',
        publishedAt: DateTime.now().subtract(const Duration(hours: 5)),
        category: 'AI',
        viralScore: 88.0,
        videoUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
      NewsArticle(
        id: '3',
        title: 'New Battery Tech Triples EV Range',
        description:
            'Revolutionary solid-state battery technology promises to change the automotive industry forever.',
        imageUrl:
            'https://images.unsplash.com/photo-1593941707882-a5bba14938c7?w=800&q=80',
        source: 'Auto Future',
        publishedAt: DateTime.now().subtract(const Duration(hours: 1)),
        category: 'Innovation',
        viralScore: 92.0,
      ),
    ];
  }
}
