import 'package:hive_flutter/hive_flutter.dart';
import '../models/news_article.dart';

class StorageService {
  static const String _favoritesBoxName = 'favorites';

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NewsArticleAdapter());
    await Hive.openBox<NewsArticle>(_favoritesBoxName);
  }

  Box<NewsArticle> get _favoritesBox =>
      Hive.box<NewsArticle>(_favoritesBoxName);

  List<NewsArticle> getFavorites() {
    return _favoritesBox.values.toList();
  }

  Future<void> addToFavorites(NewsArticle article) async {
    await _favoritesBox.put(article.id, article);
  }

  Future<void> removeFromFavorites(String articleId) async {
    await _favoritesBox.delete(articleId);
  }

  bool isFavorite(String articleId) {
    return _favoritesBox.containsKey(articleId);
  }
}
