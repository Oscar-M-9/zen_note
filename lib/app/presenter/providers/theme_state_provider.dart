import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';

enum ThemeApp {
  light,
  dark,
  blue,
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeApp>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeApp> {
  ThemeNotifier() : super(ThemeApp.light) {
    _loadTheme();
  }

  final Box box = Hive.box("setting");

  void _loadTheme() async {
    final themeString = box.get("theme");
    if (themeString != null) {
      ThemeApp currentTheme = ThemeApp.values
          .firstWhere((element) => element.toString() == themeString);
      state = currentTheme;
    }
  }

  void setTheme(ThemeApp theme) async {
    state = theme;
    box.put('theme', theme.toString());
  }
}

final themeDataProvider = Provider<ThemeData>(
  (ref) {
    final themeApp = ref.watch(themeProvider);
    return _themeData(themeApp);
  },
);

ThemeData _themeData(ThemeApp themeApp) {
  switch (themeApp) {
    case ThemeApp.dark:
      return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xF50C0C0C),
        cardColor: const Color(0xFF3C3C3C),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: ColorsApp.primeColor,
        ),
        textTheme: TextTheme(
          labelLarge: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
          ),
          headlineLarge: GoogleFonts.chewy(
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          titleLarge: GoogleFonts.lato(
            color: Colors.white,
          ),
          titleMedium: GoogleFonts.lato(
            color: Colors.white,
          ),
          bodyMedium: GoogleFonts.lato(
            color: Colors.white,
          ),
          bodySmall: GoogleFonts.lato(
            color: Colors.grey,
          ),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Color(0xFF3C3C3C),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Color(0xFF3C3C3C),
          // shadowColor: Colors.white24,
          // elevation: 5,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.transparent,
        ),
      );
    case ThemeApp.light:
    default:
      return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: ColorsApp.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        cardColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFFFCFCFC),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: ColorsApp.primeColor,
        ),
        textTheme: TextTheme(
          labelLarge: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey,
          ),
          headlineLarge: GoogleFonts.chewy(
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          titleLarge: GoogleFonts.lato(
            color: Colors.black,
          ),
          titleMedium: GoogleFonts.lato(
            color: Colors.black,
          ),
          bodyMedium: GoogleFonts.lato(
            color: Colors.black,
          ),
          bodySmall: GoogleFonts.lato(
            color: Colors.grey,
          ),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white,
          shadowColor: Colors.black26,
          elevation: 5,
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.transparent,
        ),
      );
  }
}