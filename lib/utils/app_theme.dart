import 'package:flutter/material.dart';

class AppColors {
  static const Color bg = Color(0xFF1B3226);
  static const Color bgDeep = Color(0xFF12231A);
  static const Color card = Color(0xFF264D39);
  static const Color cardHigh = Color(0xFF2F5A42);
  static const Color cardSoft = Color(0xFF3A6B50);
  static const Color chip = Color(0xFF2A4A39);
  static const Color lime = Color(0xFFC9F061);
  static const Color onLime = Color(0xFF1B3226);
  static const Color textSoft = Color(0xFFBFD8C6);
  static const Color danger = Color(0xFFFF8A80);

  static const Color primary = card;
  static const Color primaryLight = cardSoft;
  static const Color primaryDark = bgDeep;
  static const Color accent = lime;
}

class AppGradients {
  static const LinearGradient banner = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2F5A42), Color(0xFF3F7656)],
  );
  static const LinearGradient brand = banner;
}

class AppTheme {
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.lime,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: AppColors.bg,
      );

  static ThemeData get light => dark;
}