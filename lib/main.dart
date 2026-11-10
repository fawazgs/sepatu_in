import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const SepatuInApp());
}

class SepatuInApp extends StatelessWidget {
  const SepatuInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sepatu.in',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}