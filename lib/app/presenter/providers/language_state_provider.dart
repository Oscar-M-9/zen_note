import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

/// Enumerado para representar los idiomas disponibles en la aplicación.
enum LanguageApp {
  english,
  spanish,
}

/// Provider para almacenar y gestionar el idioma actual de la aplicación.
final languageProvider =
    StateNotifierProvider<LanguageNotifier, LanguageApp>((ref) {
  return LanguageNotifier();
});

/// Clase para gestionar el estado del idioma de la aplicación.
class LanguageNotifier extends StateNotifier<LanguageApp> {
  /// Referencia a la caja de Hive para almacenar el idioma seleccionado.
  final Box box = Hive.box('setting');

  /// Constructor que inicializa el estado con el idioma predeterminado (español) y carga la configuración desde Hive.
  LanguageNotifier() : super(LanguageApp.spanish) {
    _loadLanguage();
  }

  /// Carga el idioma previamente seleccionado desde Hive.
  Future<void> _loadLanguage() async {
    final languageString = box.get('language');
    if (languageString != null) {
      final language = LanguageApp.values
          .firstWhere((element) => element.toString() == languageString);
      state = language; // Actualiza el estado con el idioma cargado
    }
  }

  /// Establece un nuevo idioma para la aplicación y lo guarda en Hive.
  void setLanguage(LanguageApp language) async {
    state = language; // Actualiza el estado con el nuevo idioma
    box.put('language', language.toString()); // Guarda el idioma en Hive
  }
}

/// Provider que genera el Locale apropiado en base al idioma actual.
final localeProvider = Provider<Locale>((ref) {
  final languageApp = ref.watch(languageProvider);
  return _localeData(languageApp);
});

/// Función privada para generar el Locale en base al LanguageApp.
Locale _localeData(LanguageApp language) {
  switch (language) {
    case LanguageApp.spanish:
      return const Locale("es");
    case LanguageApp.english:
    default:
      return const Locale("en");
  }
}
