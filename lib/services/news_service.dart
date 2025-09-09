import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsService {
  // API Key baru Anda yang aktif
  static const String _apiKey = '3b8cda41c0da460fa6ebc42f23f3b313';
  static const String _baseUrl = 'https://newsapi.org/v2';

  // Mendapatkan berita teratas berdasarkan kategori
  Future<List<NewsArticle>> getTopHeadlines({
    String country = 'us',
    String category = 'general',
    int pageSize = 20,
  }) async {
    final url =
        '$_baseUrl/top-headlines?country=$country&category=$category&pageSize=$pageSize&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok') {
          final List<dynamic> articlesJson = data['articles'];
          final articles = articlesJson
              .map((article) {
                try {
                  return NewsArticle.fromJson(article);
                } catch (e) {
                  print('Error parsing article: $e');
                  print('Article data: $article');
                  return null;
                }
              })
              .whereType<NewsArticle>()
              .toList();
          return articles;
        } else {
          final errorMessage = data['message'] ?? 'Unknown API error';
          print('API returned error: $errorMessage');
          throw Exception('API error: $errorMessage');
        }
      } else {
        throw Exception(
          'Gagal memuat berita: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error mengambil data: $e');
      throw Exception('Error: $e');
    }
  }

  // Search berita
  Future<List<NewsArticle>> searchNews({
    required String query,
    int pageSize = 20,
  }) async {
    final url =
        '$_baseUrl/everything?q=$query&pageSize=$pageSize&apiKey=$_apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'ok') {
          final List<dynamic> articlesJson = data['articles'];
          return articlesJson
              .map((article) => NewsArticle.fromJson(article))
              .toList();
        }
      }
      throw Exception('Failed to search news');
    } catch (e) {
      print('Error searching news: $e');
      throw Exception('Error: $e');
    }
  }
}
