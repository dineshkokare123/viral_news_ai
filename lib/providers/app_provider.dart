import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';
import '../services/gemini_service.dart';

class AppProvider with ChangeNotifier {
  final NewsService _newsService = NewsService();
  final GeminiService _geminiService = GeminiService();

  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String? _generatedContent;
  bool _isGenerating = false;
  String _selectedCategory = 'general';

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get generatedContent => _generatedContent;
  bool get isGenerating => _isGenerating;

  String get selectedCategory => _selectedCategory;

  final List<String> categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  Future<void> loadNews({String? category}) async {
    if (category != null) {
      _selectedCategory = category;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _articles = await _newsService.fetchTrendingNews(
        category: _selectedCategory,
      );
    } catch (e) {
      debugPrint('Error loading news: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> generateContentForArticle(
    NewsArticle article,
    String platform,
  ) async {
    _isGenerating = true;
    _generatedContent = null;
    notifyListeners();

    try {
      _generatedContent = await _geminiService.generateSocialPost(
        article,
        platform,
      );
    } catch (e) {
      _generatedContent = 'Failed to generate content. Please try again.';
    } finally {
      _isGenerating = false;
      notifyListeners();
    }
  }

  void clearGeneratedContent() {
    _generatedContent = null;
    notifyListeners();
  }
}
