import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/news_article.dart';

class GeminiService {
  static const String _apiKey = 'YOUR_API_KEY';
  late final GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(model: 'gemini-2.5-pro', apiKey: _apiKey);
  }

  Future<double> analyzeViralPotential(String title, String description) async {
    try {
      final prompt =
          '''
        Analyze the viral potential of this news story for social media (0-100).
        Title: $title
        Description: $description
        
        Return ONLY a number between 0 and 100.
      ''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      final text = response.text?.trim() ?? '0';
      return double.tryParse(text.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 50.0;
    } catch (e) {
      debugPrint('Error analyzing viral potential: $e');
      return 50.0; // Default fallback
    }
  }

  Future<Map<String, double>> analyzeSentiment(
    String title,
    String description,
  ) async {
    try {
      final prompt =
          '''
        Analyze the sentiment and emotions of this news story.
        Title: $title
        Description: $description
        
        Return a JSON-like format with percentages (0-100) for these 5 emotions:
        Excitement, Fear, Joy, Controversy, Trust.
        
        Example format:
        Excitement: 80
        Fear: 10
        Joy: 5
        Controversy: 90
        Trust: 20
        
        Return ONLY the list of emotions and numbers.
      ''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      final text = response.text ?? '';

      final Map<String, double> emotions = {};
      final lines = text.split('\n');
      for (var line in lines) {
        final parts = line.split(':');
        if (parts.length == 2) {
          final key = parts[0].trim();
          final value =
              double.tryParse(parts[1].trim().replaceAll('%', '')) ?? 0.0;
          emotions[key] = value / 100.0; // Store as 0.0 - 1.0
        }
      }
      return emotions;
    } catch (e) {
      debugPrint('Error analyzing sentiment: $e');
      return {};
    }
  }

  Future<String> generateSocialPost(
    NewsArticle article,
    String platform,
  ) async {
    try {
      final prompt =
          '''
        Write a viral $platform post for this news:
        Title: ${article.title}
        Description: ${article.description}
        
        Style: Engaging, click-worthy, professional but accessible.
        Include 3 relevant hashtags at the end.
      ''';

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      return response.text ?? 'Could not generate content.';
    } catch (e) {
      return 'Error generating content: $e';
    }
  }
}
