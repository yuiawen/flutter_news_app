// lib/screens/categories_list_screen.dart

import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'category_screen.dart'; // Screen yang sudah ada sebelumnya

class CategoriesListScreen extends StatelessWidget {
  const CategoriesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: AppConstants.categories.length,
        itemBuilder: (context, index) {
          final category = AppConstants.categories[index];
          final categoryName =
              AppConstants.categoryNames[category] ?? 'Unknown';
          final categoryIcon = AppConstants.categoryIcons[category] ?? '📰';

          return ListTile(
            leading: Text(
              categoryIcon,
              style: const TextStyle(fontSize: 24),
            ),
            title: Text(categoryName),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigasi ke halaman detail kategori yang sudah ada
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(category: category),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
