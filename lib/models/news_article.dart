class NewsArticle {
  final String id;
  final String title;
  final String description;
  final String? content;
  final String imageUrl;
  final String source;
  final DateTime publishedAt;
  final String category;
  final String? videoUrl;
  double viralScore;
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
