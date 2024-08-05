import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_notes/app/infra/models/category_model.dart';

/// Provider para almacenar el nombre de la categoría activa (predeterminado "all").
final activeCategory = StateProvider<String>((ref) => "all");

/// Provider para calcular la cantidad total de categorías registradas.
final categoryLengthProvider = StateProvider<int>((ref) {
  final categories = ref.watch(categoryProvider);
  return categories.length;
});

/// Provider para verificar si existe una categoría por nombre.
final categoryExistsByNameProvider = Provider.family<bool, String>((ref, name) {
  final categories = ref.watch(categoryProvider);
  return categories.any((category) =>
      category.name.trim().toLowerCase() == name.trim().toLowerCase());
});

/// Provider para obtener una categoría por su ID.
final categoryByIdProvider = Provider.family<Category?, String>((ref, id) {
  final categories = ref.watch(categoryProvider);
  return categories.firstWhere((category) => category.id == id);
});

/// Provider para gestionar el estado de la lista de categorías utilizando Riverpod y Hive.
final categoryProvider =
    StateNotifierProvider<CategoryStateNotifier, List<Category>>((ref) {
  return CategoryStateNotifier();
});

/// Clase para gestionar el estado de la lista de categorías utilizando Riverpod y Hive.

class CategoryStateNotifier extends StateNotifier<List<Category>> {
  /// Referencia a la caja de Hive para almacenar las categorías.
  late Box<Category> categoryBox;

  /// Constructor que inicializa Hive y carga las categorías desde el almacenamiento.
  CategoryStateNotifier() : super([]) {
    _init();
  }

  /// Inicializa Hive y carga las categorías desde el almacenamiento.
  Future<void> _init() async {
    // Registra el adaptador para el modelo Category en Hive.
    Hive.registerAdapter(CategoryAdapter());

    // Abre la caja de Hive para las categorías.
    categoryBox = await Hive.openBox<Category>('categories');

    // Carga las categorías desde la caja de Hive y actualiza el estado.
    state = categoryBox.values.toList();
  }

  /// Agrega una nueva categoría a la lista y al almacenamiento de Hive.
  ///
  /// * **name:** El nombre de la nueva categoría.
  /// * **metadata:** Datos adicionales asociados a la categoría (opcional).
  ///
  /// Devuelve el ID generado para la nueva categoría.
  String addCategory({
    required String name,
    Map<String, dynamic>? metadata,
  }) {
    var uuid = const Uuid();
    final newCategory = Category(
      id: uuid.v4(), // Genera un ID único
      name: name,
      createdAt: DateTime.now(),
      updatedAt: null,
      metadata: metadata,
    );

    categoryBox.add(newCategory); // Agrega la categoría a Hive
    state = [
      ...state,
      newCategory
    ]; // Actualiza el estado con la nueva categoría
    return newCategory.id;
  }

  /// Elimina una categoría de la lista y del almacenamiento de Hive por su ID.
  ///
  /// * **id:** El ID de la categoría a eliminar.
  void deleteCategoryById(String id) {
    final categoryToDelete = state.firstWhere((category) => category.id == id);
    categoryBox.delete(categoryToDelete.key); // Elimina de Hive
    state = state
        .where((category) => category.id != id)
        .toList(); // Actualiza el estado
  }

  /// Elimina múltiples categorías de la lista y del almacenamiento de Hive.
  ///
  /// * **categoriesToDelete:** Un conjunto de categorías a eliminar.
  void deleteCategories(Set<Category> categoriesToDelete) {
    for (var category in categoriesToDelete) {
      categoryBox.delete(category.key); // Elimina de Hive
    }
    state = state
        .where((category) => !categoriesToDelete.contains(category))
        .toList(); // Actualiza el estado
  }

  /// Actualiza una categoría existente en la lista y en el almacenamiento de Hive.
  ///
  /// * **id:** El ID de la categoría a actualizar.
  /// * **name:** El nuevo nombre de la categoría.
  /// * **metadata:** Nuevos datos adicionales (opcional).
  void updateCategoryById({
    required String id,
    required String name,
    Map<String, dynamic>? metadata,
  }) {
    final categoryIndex = state.indexWhere((category) => category.id == id);
    if (categoryIndex != -1) {
      final updatedCategory = state[categoryIndex].copyWith(
        name: name,
        updatedAt: DateTime.now(),
        metadata: metadata,
      );

      categoryBox.put(
          state[categoryIndex].key, updatedCategory); // Actualiza en Hive
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == categoryIndex) updatedCategory else state[i]
      ];
    }
  }

  /// Método para buscar una categoría por nombre.
  ///
  /// Busca si existe una categoría con el nombre proporcionado, teniendo en cuenta las diferencias entre mayúsculas y minúsculas.
  ///
  /// * **name:** El nombre de la categoría a buscar.
  ///
  /// Devuelve `true` si la categoría existe, `false` en caso contrario.
  bool categoryExistsByName(String name) {
    return state.any((category) =>
        category.name.trim().toLowerCase() == name.trim().toLowerCase());
  }
}
