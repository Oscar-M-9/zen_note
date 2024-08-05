import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_notes/app/infra/models/note_model.dart';

/// Provider para obtener la cantidad total de notas registradas.
final noteLengthProvider = StateProvider<int>((ref) {
  /// Obtiene la lista de notas del `noteProvider`.
  final notes = ref.watch(noteProvider);

  /// Devuelve la longitud de la lista de notas (cantidad de notas).
  return notes.length;
});

/// Provider para obtener la cantidad de notas agrupadas por categoría.
final notesByCategoryProvider = Provider<Map<String, int>>((ref) {
  /// Obtiene la lista de notas del `noteProvider`.
  final notes = ref.watch(noteProvider);

  /// Crea un mapa para almacenar la cantidad de notas por categoría.
  final Map<String, int> categoryCount = {};

  /// Recorre la lista de notas.
  for (var note in notes) {
    /// Obtiene la categoría de la nota (o 'uncategorized' si no tiene).
    final categoryId = note.categoryId ?? 'uncategorized';

    /// Incrementa el contador de la categoría correspondiente en el mapa.
    categoryCount[categoryId] = (categoryCount[categoryId] ?? 0) + 1;
  }

  /// Devuelve el mapa con la cantidad de notas por categoría.
  return categoryCount;
});

/// Provider para obtener una nota específica por su ID.
final noteByIdProvider = Provider.family<Note?, String>((ref, id) {
  /// Obtiene la lista de notas del `noteProvider`.
  final notes = ref.watch(noteProvider);

  /// Busca la primera nota en la lista cuyo ID coincida con el proporcionado.
  return notes.firstWhere((note) => note.id == id);
});

/// Provider para gestionar el estado de la lista de notas utilizando Riverpod y Hive.
final noteProvider =
    StateNotifierProvider<NoteStateNotifier, List<Note>>((ref) {
  return NoteStateNotifier();
});

/// Clase para gestionar el estado de la lista de notas utilizando Riverpod y Hive.
class NoteStateNotifier extends StateNotifier<List<Note>> {
  /// Referencia a la caja de Hive para almacenar las notas.
  late Box<Note> noteBox;

  /// Constructor que inicializa Hive y carga las notas desde el almacenamiento.
  NoteStateNotifier() : super([]) {
    _init();
  }

  /// Inicializa Hive y carga las notas desde el almacenamiento.
  void _init() async {
    // Registra el adaptador necesario para convertir Note a/desde JSON en Hive.
    Hive.registerAdapter(NoteAdapter());

    // Abre la caja de Hive específica para las notas.
    noteBox = await Hive.openBox<Note>('notes');

    // Carga las notas guardadas en la caja de Hive y actualiza el estado.
    state = noteBox.values.toList();
  }

  /// Agrega una nueva nota a la lista y al almacenamiento de Hive.
  ///
  /// * **title:** El título de la nota.
  /// * **content:** El contenido de la nota.
  /// * **favorite:** Carpeta opcional para la nota (no implementado).
  /// * **pinned:** Carpeta opcional para la nota (no implementado).
  /// * **metadata:** Datos adicionales asociados a la nota (opcional).
  /// * **categoryId:** ID de la categoría a la que pertenece la nota (opcional).
  /// * **documentJson:** Json opcional para documentos adjuntos (opcional).
  ///
  /// Devuelve el ID generado para la nueva nota.
  void addNote({
    required String title,
    required String content,
    String? folder,
    Map<String, dynamic>? metadata,
    String? categoryId,
    String? documentJson,
  }) {
    var uuid = const Uuid();
    final newNote = Note(
      id: uuid.v4(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: null,
      categoryId: categoryId,
      favorite: false, //  no implementada
      pinned: false, //  no implementada
      metadata: metadata,
      documentJson: documentJson,
    );

    // Agrega la nueva nota a la caja de Hive.
    noteBox.add(newNote);

    // Actualiza el estado de la lista de notas con la nueva nota agregada.
    state = [...state, newNote];
  }

  /// Elimina una nota de la lista y del almacenamiento de Hive por su ID.
  ///
  /// * **id:** El ID de la nota a eliminar.
  void deleteNoteById(String id) {
    // Busca la nota a eliminar en la lista actual.
    final noteToDelete = state.firstWhere((note) => note.id == id);

    // Elimina la nota de la caja de Hive.
    noteBox.delete(noteToDelete.key);

    // Filtra la lista de notas para excluir la eliminada y actualiza el estado.
    state = state.where((note) => note.id != id).toList();
  }

  /// Elimina múltiples notas de la lista y del almacenamiento de Hive.
  ///
  /// * **notesToDelete:** Un conjunto de notas a eliminar.
  void deleteNotes(Set<Note> notesToDelete) {
    // Recorre las notas a eliminar.
    for (var note in notesToDelete) {
      // Elimina cada nota de la caja de Hive.
      noteBox.delete(note.key);
    }

    // Filtra la lista de notas para excluir las eliminadas y actualiza el estado.
    state = state.where((note) => !notesToDelete.contains(note)).toList();
  }

  /// Actualiza una nota existente en la lista y en el almacenamiento de Hive.
  ///
  /// * **id:** El ID de la nota a actualizar.
  /// * **title:** El nuevo título de la nota.
  /// * **content:** El nuevo contenido de la nota.
  /// * **categoryId:** Nueva categoría opcional para la nota.
  /// * **documentJson:** Nuevo Json opcional para documentos adjuntos.
  /// * **metadata:** Nuevos datos adicionales (opcional).
  void updateNoteById({
    required String id,
    required String title,
    required String content,
    String? categoryId,
    String? documentJson,
    Map<String, dynamic>? metadata,
  }) {
    // Busca el índice de la nota a actualizar en la lista actual.
    final noteIndex = state.indexWhere((note) => note.id == id);
    // Verifica si se encontró la nota con el ID proporcionado.
    if (noteIndex != -1) {
      // Crea una copia de la nota a actualizar con los nuevos valores.
      final updatedNote = state[noteIndex].copyWith(
        title: title,
        content: content,
        updatedAt: DateTime.now(), // Actualiza la fecha de modificación
        metadata: metadata,
        categoryId: categoryId,
        documentJson: documentJson,
      );
      // Actualiza la nota en la caja de Hive con la versión modificada.
      noteBox.put(state[noteIndex].key, updatedNote);
      // Actualiza el estado de la lista de notas reemplazando la antigua versión
      // de la nota por la actualizada.
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
