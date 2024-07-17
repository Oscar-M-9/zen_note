import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_notes/app/infra/models/note_model.dart';

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
    String? category,
    String? file,
    Map<String, dynamic>? metadata,
  }) {
    var uuid = const Uuid();
    final note = Note(
      id: uuid.v4(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: null,
      category: null,
      file: null,
      metadata: metadata,
    );

    noteBox.add(note);
    state = [...state, note];
  }

  // void deleteNoteAt(int index) {
  //   noteBox?.deleteAt(index);
  //   state = List.from(state)..removeAt(index);
  // }
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

  // void updateNoteAt(int index, String title, String content, String? category,
  //     String? file, Map<String, dynamic>? metadata) {
  //   final note = state[index];
  //   final updatedNote = Note(
  //     id: note.id,
  //     title: title,
  //     content: content,
  //     category: category,
  //     file: file,
  //     updatedAt: DateTime.now(),
  //     metadata: metadata,
  //   );

  //   noteBox?.putAt(index, updatedNote);
  //   state = List.from(state)
  //     ..removeAt(index)
  //     ..insert(index, updatedNote);
  // }
  void updateNoteById({
    required String id,
    required String title,
    required String content,
    String? category,
    String? file,
    Map<String, dynamic>? metadata,
  }) {
    // final note = state.firstWhere((note) => note.id == id);
    // note
    //   ..title = title
    //   ..content = content
    //   ..category = category
    //   ..file = file
    //   ..updatedAt = DateTime.now()
    //   ..metadata = metadata;

    // note.save();
    // state = state.map((n) => n.id == id ? note : n).toList();
    final noteIndex = state.indexWhere((note) => note.id == id);
    if (noteIndex != -1) {
      final updatedNote = state[noteIndex].copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(),
        metadata: metadata,
      );

      noteBox.put(state[noteIndex].key, updatedNote);
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == noteIndex) updatedNote else state[i]
      ];
    }
  }
}
