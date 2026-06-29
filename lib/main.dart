import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'landing_page.dart';
import 'theme_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const UstadXApp());
}

class UstadXApp extends StatelessWidget {
  const UstadXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'UstadX Systems',
          debugShowCheckedModeBanner: false,
          theme: _buildLightIndustrialTheme(),
          darkTheme: _buildDarkIndustrialTheme(),
          themeMode: currentMode,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: true,
          ),
          home: const LandingPage(),
        );
      },
    );
  }

  ThemeData _buildDarkIndustrialTheme() {
    const Color background = Color(0xFF0A0A0F);
    const Color surface = Color(0xFF141420);
    const Color surfaceVariant = Color(0xFF1C1C2E);
    const Color accent = Color(0xFF00E5FF);
    const Color accentWarm = Color(0xFFFFB800);
    const Color textPrimary = Color(0xFFF0F0F5);
    const Color textSecondary = Color(0xFF8A8A9E);
    const Color border = Color(0xFF2A2A3E);

    final headlineFont = GoogleFonts.spaceGrotesk();
    final bodyFont = GoogleFonts.inter();

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: accent,
      cardColor: surface,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accentWarm,
        surface: surface,
        surfaceContainerHighest: surfaceVariant,
        onSurface: textPrimary,
        onSurfaceVariant: textSecondary,
        outline: border,
      ),
      textTheme: TextTheme(
        displayLarge: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 64,
          fontWeight: FontWeight.w700,
          height: 1.1,
          letterSpacing: -1.5,
        ),
        displayMedium: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 1.1,
          letterSpacing: -1.0,
        ),
        displaySmall: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 36,
          fontWeight: FontWeight.w700,
          height: 1.15,
          letterSpacing: -0.5,
        ),
        headlineLarge: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        headlineMedium: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        headlineSmall: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: bodyFont.copyWith(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.6,
        ),
        titleSmall: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 18,
          height: 1.7,
        ),
        bodyMedium: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 16,
          height: 1.6,
        ),
        bodySmall: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 14,
          height: 1.5,
        ),
        labelLarge: bodyFont.copyWith(
          color: accent,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        labelMedium: bodyFont.copyWith(
          color: accent,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface.withAlpha(200),
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: bodyFont.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accent,
          side: const BorderSide(color: accent, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: bodyFont.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        labelStyle: bodyFont.copyWith(color: textSecondary),
        hintStyle: bodyFont.copyWith(color: textSecondary.withAlpha(128)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: accent,
        contentTextStyle: bodyFont.copyWith(
          color: background,
          fontWeight: FontWeight.w600,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  ThemeData _buildLightIndustrialTheme() {
    const Color background = Color(0xFFF8F9FA);
    const Color surface = Color(0xFFFFFFFF);
    const Color surfaceVariant = Color(0xFFE2E8F0);
    const Color accent = Color(0xFF0097A7);
    const Color accentWarm = Color(0xFFF57C00);
    const Color textPrimary = Color(0xFF1E293B);
    const Color textSecondary = Color(0xFF475569);
    const Color border = Color(0xFFCBD5E1);
    const Color divider = Color(0xFFE2E8F0);

    final headlineFont = GoogleFonts.spaceGrotesk();
    final bodyFont = GoogleFonts.inter();

    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: background,
      primaryColor: accent,
      cardColor: surface,
      dividerColor: divider,
      colorScheme: const ColorScheme.light(
        primary: accent,
        secondary: accentWarm,
        surface: surface,
        surfaceContainerHighest: surfaceVariant,
        onSurface: textPrimary,
        onSurfaceVariant: textSecondary,
        outline: border,
      ),
      textTheme: TextTheme(
        displayLarge: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 64,
          fontWeight: FontWeight.w700,
          height: 1.1,
          letterSpacing: -1.5,
        ),
        displayMedium: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 48,
          fontWeight: FontWeight.w700,
          height: 1.1,
          letterSpacing: -1.0,
        ),
        displaySmall: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 36,
          fontWeight: FontWeight.w700,
          height: 1.15,
          letterSpacing: -0.5,
        ),
        headlineLarge: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        headlineMedium: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.3,
        ),
        headlineSmall: headlineFont.copyWith(
          color: textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: bodyFont.copyWith(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.6,
        ),
        titleSmall: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 18,
          height: 1.7,
        ),
        bodyMedium: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 16,
          height: 1.6,
        ),
        bodySmall: bodyFont.copyWith(
          color: textSecondary,
          fontSize: 14,
          height: 1.5,
        ),
        labelLarge: bodyFont.copyWith(
          color: accent,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        labelMedium: bodyFont.copyWith(
          color: accent,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface.withAlpha(240),
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: surface,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: bodyFont.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accent,
          side: const BorderSide(color: accent, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: bodyFont.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        labelStyle: bodyFont.copyWith(color: textSecondary),
        hintStyle: bodyFont.copyWith(color: textSecondary.withAlpha(128)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: textPrimary,
        contentTextStyle: bodyFont.copyWith(
          color: surface,
          fontWeight: FontWeight.w600,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
