// lib/main.dart (MODIFIKASI)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'screens/home_screen.dart'; // Hapus atau biarkan
import 'screens/main_screen.dart'; // <-- TAMBAHKAN IMPORT INI
import 'utils/theme.dart';
import 'services/news_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NewsService>(create: (_) => NewsService()),
      ],
      child: MaterialApp(
        title: 'News Today - Breaking News & Headlines',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const MainScreen(), // <-- GANTI DARI HomeScreen KE MainScreen
      ),
    );
  }
}
