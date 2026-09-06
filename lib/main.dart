import 'package:flutter/material.dart';
import 'screens/shop_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1Fi Marketplace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B21A8),
          primary: const Color(0xFF6B21A8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0F172A),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF0B0F19), // Dark desktop backdrop
          body: Center(
            child: Container(
              width: 390,
              height: 800,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36),
                border: Border.all(color: const Color(0xFF334155), width: 10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: child!,
              ),
            ),
          ),
        );
      },
      home: const ShopPage(),
    );
  }
}