import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_notes/app/infra/models/category_model.dart';

final selectedCategoryProvider =
    StateNotifierProvider<SelectedCategoryNotifier, Set<Category>>((ref) {
  return SelectedCategoryNotifier();
});

class SelectedCategoryNotifier extends StateNotifier<Set<Category>> {
  SelectedCategoryNotifier() : super({});

  void toggle(Category category) {
    if (state.contains(category)) {
      state = {...state}..remove(category);
    } else {
      state = {...state}..add(category);
    }
  }

  void clear() {
    state = {};
  }
}
