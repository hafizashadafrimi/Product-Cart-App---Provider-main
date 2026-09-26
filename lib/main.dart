import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => CartProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Cart App',

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor: const Color(0xFFF7F4EC),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF073B4C),
          brightness: Brightness.light,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF073B4C),
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        cardTheme: const CardThemeData(color: Color(0xFFFFFDF8), elevation: 2),

        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF073B4C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),

      home: const ProductListScreen(),
    );
  }
}
