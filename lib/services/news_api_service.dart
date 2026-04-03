import 'package:dio/dio.dart';
import '../models/article_model.dart';

/// Client for [News API](https://newsapi.org/). URL shape matches the legacy app — change with care.
class NewsApiService {
  NewsApiService() : _dio = Dio();

  final Dio _dio;

  /// Legacy segment embedded key + trailing `&category` (used by top-headlines URL).
  static const String _legacyKeySegment =
      '1acb0c680dc8465085d2f5a0f6bcb0d6&category';

  Future<List<ArticleModel>> fetchTopHeadlines({
    required String category,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_legacyKeySegment=$category',
      );
      final articles = response.data?['articles'] as List<dynamic>? ?? [];
      return _parseArticles(articles);
    } catch (_) {
      return [];
    }
  }

  Future<List<ArticleModel>> searchEverything({required String query}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://newsapi.org/v2/everything?q=$query&apiKey=$_legacyKeySegment',
      );
      final articles = response.data?['articles'] as List<dynamic>? ?? [];
      return _parseArticles(articles);
    } catch (_) {
      return [];
    }
  }

  static List<ArticleModel> _parseArticles(List<dynamic> raw) {
    final out = <ArticleModel>[];
    for (final e in raw) {
      if (e is! Map) continue;
      try {
        out.add(ArticleModel.fromJson(Map<String, dynamic>.from(e)));
      } catch (_) {}
    }
    return out;
  }
}
