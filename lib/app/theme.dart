import 'package:flutter/material.dart';

class AppColors {
  static const green = Color(0xFF049239);
  static const green2 = Color(0xFF33A55D);
  static const pale = Color(0xFFE8F4EA);
  static const ink = Color(0xFF1D1D1B);
  static const orange = Color(0xFFAA5A24);
  static const orangebg = Color(0xFFFFF0E7);
  static const paper = Color(0xFFF4F7F3);
  static const background = Color(0xFFDFE9E1);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = ink;
  static const textSecondary = Color(0xFF647169);
  static const border = Color(0xFFC8D4CA);
  static const muted = Color(0xFF9AA69E);
  static const greenBg = Color(0xFFE5F3E8);
  static const blue = Color(0xFF2563EB);
  static const blueBg = Color(0xFFDBEAFE);
  static const error = Color(0xFFDC2626);
  static const red = Color(0xFFDC2626);
  static const success = Color(0xFF16A34A);
  static const line = Color(0xFFC8D4CA);
  static const primary = green;
  static const primary2 = green2;
}

class AppTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.green,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.green,
          unselectedItemColor: AppColors.muted,
          elevation: 8,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.line),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.green),
          ),
          fillColor: AppColors.surface,
          filled: true,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          margin: EdgeInsets.zero,
        ),
        colorScheme: ColorScheme.light(
          primary: AppColors.green,
          secondary: AppColors.green2,
          error: AppColors.red,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.015,
            color: AppColors.ink,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
          titleMedium: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.ink,
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            height: 1.45,
            color: AppColors.ink,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: AppColors.ink,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
          ),
        ),
      );

  static ThemeData get dark => light;
}

class OutfitText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final double? height;

  const OutfitText({
    super.key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.color,
    this.textAlign,
    this.letterSpacing,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
      ),
      textAlign: textAlign,
    );
  }
}
