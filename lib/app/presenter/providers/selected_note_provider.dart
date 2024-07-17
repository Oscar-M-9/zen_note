import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_notes/app/infra/models/note_model.dart';

final selectedNotesProvider =
    StateNotifierProvider<SelectedNotesNotifier, Set<Note>>((ref) {
  return SelectedNotesNotifier();
});

class SelectedNotesNotifier extends StateNotifier<Set<Note>> {
  SelectedNotesNotifier() : super({});

  void toggle(Note note) {
    if (state.contains(note)) {
      state = {...state}..remove(note);
    } else {
      state = {...state}..add(note);
    }
  }

  void clear() {
    state = {};
  }
}
