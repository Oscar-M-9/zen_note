import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

enum LanguageApp {
  english,
  spanish,
}

final languageProvider =
    StateNotifierProvider<LanguageNotifier, LanguageApp>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<LanguageApp> {
  LanguageNotifier() : super(LanguageApp.english) {
    _loadLanguage();
  }

  final Box box = Hive.box('setting');

  void _loadLanguage() async {
    final languageString = box.get('language');
    if (languageString != null) {
      LanguageApp language = LanguageApp.values
          .firstWhere((element) => element.toString() == languageString);
      state = language;
    }
  }

  void setLanguage(LanguageApp language) async {
    state = language;
    box.put('language', language.toString());
  }
}

final localeProvider = Provider<Locale>((ref) {
  final languageApp = ref.watch(languageProvider);
  return _localeData(languageApp);
});

Locale _localeData(LanguageApp language) {
  switch (language) {
    case LanguageApp.spanish:
      return const Locale("es");
    case LanguageApp.english:
    default:
      return const Locale("en");
  }
}
