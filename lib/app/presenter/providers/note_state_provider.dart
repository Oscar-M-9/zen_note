import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_notes/app/infra/models/note_model.dart';

// Provider para obtener la cantidad de notas registradas
final noteLengthProvider = StateProvider<int>((ref) {
  final notes = ref.watch(noteProvider);
  return notes.length;
});

// Otención de cantidad de notas por categoria
final notesByCategoryProvider = Provider<Map<String, int>>((ref) {
  final notes = ref.watch(noteProvider);

  final Map<String, int> categoryCount = {};

  for (var note in notes) {
    final categoryId = note.categoryId ?? 'uncategorized';
    categoryCount[categoryId] = (categoryCount[categoryId] ?? 0) + 1;
  }

  return categoryCount;
});

// Provider para obtener una nota por ID
final noteByIdProvider = Provider.family<Note?, String>((ref, id) {
  final notes = ref.watch(noteProvider);
  return notes.firstWhere((note) => note.id == id);
});

final noteProvider =
    StateNotifierProvider<NoteStateNotifier, List<Note>>((ref) {
  return NoteStateNotifier();
});

class NoteStateNotifier extends StateNotifier<List<Note>> {
  late Box<Note> noteBox;

  NoteStateNotifier() : super([]) {
    _init();
  }

  void _init() async {
    Hive.registerAdapter(NoteAdapter());
    noteBox = await Hive.openBox<Note>('notes');
    state = noteBox.values.toList();
  }

  void addNote({
    required String title,
    required String content,
    String? folder,
    Map<String, dynamic>? metadata,
    String? categoryId,
  }) {
    var uuid = const Uuid();
    final note = Note(
      id: uuid.v4(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: null,
      categoryId: categoryId,
      folder: null,
      metadata: metadata,
    );

    noteBox.add(note);
    state = [...state, note];
  }

  void deleteNoteById(String id) {
    final note = state.firstWhere((note) => note.id == id);
    noteBox.delete(note.key);
    state = state.where((note) => note.id != id).toList();
  }

  // Método para eliminar notas
  void deleteNotes(Set<Note> notesToDelete) {
    for (var note in notesToDelete) {
      noteBox.delete(note.key);
    }
    state = state.where((note) => !notesToDelete.contains(note)).toList();
  }

  void updateNoteById({
    required String id,
    required String title,
    required String content,
    String? categoryId,
    Map<String, dynamic>? metadata,
  }) {
    final noteIndex = state.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      final updatedNote = state[noteIndex].copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(),
        metadata: metadata,
        categoryId: categoryId,
      );

      noteBox.put(state[noteIndex].key, updatedNote);
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == noteIndex) updatedNote else state[i]
      ];
    }
  }

  void updateNotesCategory(Set<Note> selectedNotes, String? newCategoryId) {
    final updatedNotes = state.map((note) {
      if (selectedNotes.contains(note)) {
        final updatedNote = note.copyWith(
          categoryId: newCategoryId,
          // updatedAt: DateTime.now(),
        );
        noteBox.put(note.key, updatedNote);
        return updatedNote;
      }
      return note;
    }).toList();

    state = updatedNotes;
  }

  // Método para filtrar notas por categoría
  List<Note> filterNotesByCategory(String categoryId) {
    return state.where((note) => note.categoryId == categoryId).toList();
  }

  // Método para eliminar notas por categoría
  void deleteNotesByCategory(List<String> categoryIds) {
    final notesToDelete =
        state.where((note) => categoryIds.contains(note.categoryId)).toList();

    for (var note in notesToDelete) {
      noteBox.delete(note.key);
    }

    state =
        state.where((note) => !categoryIds.contains(note.categoryId)).toList();
  }
}
