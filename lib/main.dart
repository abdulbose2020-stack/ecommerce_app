import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/main_navigation.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: AppTheme.lightTheme,
      home: const MainNavigation(),
    );
  }
}