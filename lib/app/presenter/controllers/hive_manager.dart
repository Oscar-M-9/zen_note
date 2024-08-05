import 'package:hive_flutter/adapters.dart';

/// Clase para gestionar la inicialización y apertura de cajas de Hive.
class HiveManager {
  /// Inicializa Hive y abre una caja llamada 'setting'.
  ///
  /// Este método debe ser llamado una vez, preferentemente al inicio de la aplicación,
  /// para configurar Hive y asegurarse de que la caja 'setting' esté lista para su uso.
  static Future<void> init() async {
    // Inicializa Hive con soporte para Flutter.
    await Hive.initFlutter();

    // Abre una caja llamada 'setting'.
    await Hive.openBox('setting');
  }
}
