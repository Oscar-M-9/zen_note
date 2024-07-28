import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_notes/app/infra/models/category_model.dart';

final activeCategory = StateProvider<String>((ref) {
  return "all";
});

// Provider para obtener la cantidad de notas registradas
final categoryLengthProvider = StateProvider<int>((ref) {
  final categories = ref.watch(categoryProvider);
  return categories.length;
});

// Provider que verifica si existe una categoria registrada
final categoryExistsByNameProvider = Provider.family<bool, String>((ref, name) {
  final categories = ref.watch(categoryProvider);
  return categories.any((category) =>
      category.name.trim().toLowerCase() == name.trim().toLowerCase());
});

// Provider para obtener una nota por ID
final categoryByIdProvider = Provider.family<Category?, String>((ref, id) {
  final categories = ref.watch(categoryProvider);
  return categories.firstWhere((category) => category.id == id);
});

final categoryProvider =
    StateNotifierProvider<CategoryStateNotifier, List<Category>>((ref) {
  return CategoryStateNotifier();
});

class CategoryStateNotifier extends StateNotifier<List<Category>> {
  late Box<Category> categoryBox;

  CategoryStateNotifier() : super([]) {
    _init();
  }

  void _init() async {
    Hive.registerAdapter(CategoryAdapter());
    categoryBox = await Hive.openBox<Category>('category');
    state = categoryBox.values.toList();
  }

  // agregar categoria
  String addCategory({
    required String name,
    Map<String, dynamic>? metadata,
  }) {
    var uuid = const Uuid();
    final category = Category(
      id: uuid.v4(),
      name: name,
      createdAt: DateTime.now(),
      updatedAt: null,
      metadata: metadata,
    );

    categoryBox.add(category);
    state = [...state, category];
    return category.id; // Retornar el ID de la categoría creada1
  }

  // eliminar categoria por id
  void deleteCategoryById(String id) {
    final category = state.firstWhere((category) => category.id == id);
    categoryBox.delete(category.key);
    state = state.where((category) => category.id != id).toList();
  }

  // Método para eliminar categorias
  void deleteCategories(Set<Category> categoriesToDelete) {
    for (var category in categoriesToDelete) {
      categoryBox.delete(category.key);
    }
    state = state
        .where((category) => !categoriesToDelete.contains(category))
        .toList();
  }

  // actualizar categoria por id
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

      categoryBox.put(state[categoryIndex].key, updatedCategory);
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == categoryIndex) updatedCategory else state[i]
      ];
    }
  }

  // Método para buscar una categoría por nombre
  bool categoryExistsByName(String name) {
    return state.any((category) =>
        category.name.trim().toLowerCase() == name.trim().toLowerCase());
  }
}
