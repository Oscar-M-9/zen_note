import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: ColorsApp.primeColor,
        ),
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
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            color: Colors.white,
          ),
          headlineLarge: TextStyle(
            fontFamily: "Chewy",
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontFamily: "Lato",
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontFamily: "Lato",
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Lato",
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontFamily: "Lato",
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
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xFF3C3C3C),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xFF1F1F1F),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorsApp.primary,
          selectionColor: ColorsApp.primary.withOpacity(0.8),
          selectionHandleColor: ColorsApp.primary,
        ),
      );

    case ThemeApp.light:
    default:
      return ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: ColorsApp.primeColor,
          brightness: Brightness.light,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: ColorsApp.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F6F6),
          foregroundColor: Colors.black,
        ),
        cardColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFFF6F6F6),
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            color: Colors.grey,
          ),
          headlineLarge: TextStyle(
            fontFamily: "Chewy",
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          titleLarge: TextStyle(
            fontFamily: "Lato",
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontFamily: "Lato",
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Lato",
            color: Colors.black,
          ),
          bodySmall: TextStyle(
            fontFamily: "Lato",
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
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Color(0xFFEAEAEA),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFFF6F6F6),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorsApp.primary,
          selectionColor: ColorsApp.primary.withOpacity(0.8),
          selectionHandleColor: ColorsApp.primary,
        ),
      );
  }
}
