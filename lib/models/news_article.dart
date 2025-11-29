import 'package:hive/hive.dart';

part 'news_article.g.dart';

@HiveType(typeId: 0)
class NewsArticle {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String? content;
  @HiveField(4)
  final String imageUrl;
  @HiveField(5)
  final String source;
  @HiveField(6)
  final DateTime publishedAt;
  @HiveField(7)
  final String category;
  @HiveField(8)
  final String? videoUrl;
  @HiveField(9)
  double viralScore;
  @HiveField(10)
  List<String> generatedHashtags;

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    this.content,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
    required this.category,
    this.videoUrl,
    this.viralScore = 0.0,
    this.generatedHashtags = const [],
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['url'] ?? DateTime.now().toIso8601String(),
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      content: json['content'],
      imageUrl:
          json['urlToImage'] ?? 'https://placehold.co/600x400/png?text=News',
      source: json['source']?['name'] ?? 'Unknown Source',
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : DateTime.now(),
      category: json['category'] ?? 'General',
      videoUrl: json['videoUrl'],
    );
  }
}
