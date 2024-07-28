import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_notes/app/presenter/providers/note_state_provider.dart';
import 'package:my_notes/app/presenter/providers/selected_note_provider.dart';

void updateCategoryOfSelectedNotes(WidgetRef ref, String? newCategoryId) {
  final selectedNotes = ref.read(selectedNotesProvider);
  ref
      .read(noteProvider.notifier)
      .updateNotesCategory(selectedNotes, newCategoryId);
  ref.read(selectedNotesProvider.notifier).clear();
}
