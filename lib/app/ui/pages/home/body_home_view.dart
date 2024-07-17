import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_notes/app/config/router/router.gr.dart';
import 'package:my_notes/app/infra/models/note_model.dart';
import 'package:my_notes/app/presenter/providers/note_state_provider.dart';
import 'package:my_notes/app/presenter/providers/search_query_note_provider.dart';
import 'package:my_notes/app/presenter/providers/selected_note_provider.dart';
import 'package:my_notes/app/ui/pages/home/widgets/card_note.dart';
import 'package:my_notes/app/ui/pages/home/widgets/empty_notes.dart';

class BodyHomeView extends ConsumerWidget {
  const BodyHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(noteProvider);
    final selectedNotes = ref.watch(selectedNotesProvider);
    final searchQuery = ref.watch(controllerSearchProvider);

    // Filtrar notas basadas en la consulta de búsqueda
    final filteredNotes = notes.where((note) {
      final titleLower = note.title.toLowerCase();
      final contentLower = note.content.toLowerCase();
      final searchLower = searchQuery.toLowerCase();
      return titleLower.contains(searchLower) ||
          contentLower.contains(searchLower);
    }).toList();

    // Ordenar las notas por fecha de creación en orden descendente
    final sortedNotes = List<Note>.from(filteredNotes)
      ..sort((a, b) {
        final aDate = a.updatedAt ?? a.createdAt!;
        final bDate = b.updatedAt ?? b.createdAt!;
        return bDate.compareTo(aDate);
      });

    return filteredNotes.isEmpty
        ? const EmptyNotes()
        : ListNote(
            notes: sortedNotes,
            selectedNotes: selectedNotes,
            onSelectionChanged: (note) {
              ref.read(selectedNotesProvider.notifier).toggle(note);
            },
          );
  }
}

class ListNote extends StatelessWidget {
  const ListNote({
    super.key,
    required this.notes,
    required this.selectedNotes,
    required this.onSelectionChanged,
  });

  final List<Note> notes;
  final Set<Note> selectedNotes;
  final Function(Note) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        bottom: selectedNotes.isEmpty ? 12 : 70,
        top: 12,
        right: 10,
        left: 10,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final note = notes[index];
            return CardNote(
              item: notes.length - index,
              selected: selectedNotes.contains(note),
              onTap: () {
                if (selectedNotes.isNotEmpty) {
                  onSelectionChanged(note);
                } else {
                  context.router.push(UpdateNoteRoute(note: note));
                }
              },
              onLongPress: () {
                onSelectionChanged(note);
              },
              note: note,
            );
          },
          childCount: notes.length,
        ),
      ),
    );
    // return SliverPadding(
    //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    //   sliver: SliverGrid(
    //     delegate: SliverChildBuilderDelegate(
    //       (context, index) {
    //         final note = notes[index];

    //         return CardNote(
    //           item: notes.length - index,
    //           onTap: () {
    //             context.router.push(UpdateNoteRoute(note: note));
    //           },
    //           note: note,
    //         );
    //       },
    //       childCount: notes.length,
    //     ),
    //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //       maxCrossAxisExtent: 200.0,
    //       mainAxisSpacing: 5.0,
    //       crossAxisSpacing: 5.0,
    //       childAspectRatio: 0.8,
    //       mainAxisExtent: 170,
    //     ),
    //   ),
    // );
  }
}
