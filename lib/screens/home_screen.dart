// lib/screens/home_screen.dart (MODIFIKASI)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/news_service.dart';
import '../models/news_model.dart';
import '../utils/constants.dart';
import '../widgets/news_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/shimmer_loading.dart';
// import 'category_screen.dart'; // Tidak perlu lagi di sini
// import 'search_screen.dart';   // Hapus import ini
import 'article_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsArticle> _articles = [];
  bool _isLoading = true;
  String _selectedCategory = 'general';
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    // ... (Fungsi _loadNews tetap sama, tidak perlu diubah)
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final newsService = context.read<NewsService>();
      final articles = await newsService.getTopHeadlines(
        category: _selectedCategory,
      );
      if (mounted) {
        setState(() {
          _articles = articles;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: const Text('News Today'),
            // HAPUS BAGIAN 'actions' DARI SINI
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: AppConstants.categories.length,
                itemBuilder: (context, index) {
                  final category = AppConstants.categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CategoryChip(
                      category: category,
                      isSelected: category == _selectedCategory,
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                        _loadNews();
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          if (_isLoading)
            // ... (Sisa kode build tetap sama)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const ShimmerLoading(),
                childCount: 5,
              ),
            )
          else if (_error != null)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load news',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _loadNews,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          else if (_articles.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Text('No articles found'),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final article = _articles[index];
                  return NewsCard(
                    article: article,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(
                            article: article,
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: _articles.length,
              ),
            ),
        ],
      ),
    );
  }
}
