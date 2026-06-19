import 'package:flutter/material.dart';

import 'landing_page.dart';

void main() {
  runApp(const UstadXApp());
}

class UstadXApp extends StatelessWidget {
  const UstadXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UstadX Systems',
      debugShowCheckedModeBanner: false,
      theme: _buildDarkIndustrialTheme(),
      home: const LandingPage(),
    );
  }

  ThemeData _buildDarkIndustrialTheme() {
    const Color background = Color(0xFF121212);
    const Color surface = Color(0xFF1E1E1E);
    const Color accent = Color(0xFF00E5FF);
    const Color textPrimary = Color(0xFFFFFFFF);
    const Color textSecondary = Color(0xFF9E9E9E);

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: accent,
      cardColor: surface,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accent,
        surface: surface,
        background: background,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: textPrimary),
        displayMedium: TextStyle(color: textPrimary),
        displaySmall: TextStyle(color: textPrimary),
        headlineLarge: TextStyle(color: textPrimary),
        headlineMedium: TextStyle(color: textPrimary),
        headlineSmall: TextStyle(color: textPrimary),
        titleLarge: TextStyle(color: textPrimary),
        titleMedium: TextStyle(color: textPrimary),
        titleSmall: TextStyle(color: textPrimary),
        bodyLarge: TextStyle(color: textSecondary),
        bodyMedium: TextStyle(color: textSecondary),
        labelLarge: TextStyle(color: accent),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: textPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: background,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accent,
          side: const BorderSide(color: accent),
        ),
      ),
    );
  }
}
