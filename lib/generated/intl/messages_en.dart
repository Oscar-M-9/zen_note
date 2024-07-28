// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(value) => "¿Delete all selected notes (${value})?";

  static String m1(s) => "selected${s} item${s}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "tAccept": MessageLookupByLibrary.simpleMessage("Accept"),
        "tAddATitle": MessageLookupByLibrary.simpleMessage("Agregue un título"),
        "tAddNoteButton":
            MessageLookupByLibrary.simpleMessage("Add note button"),
        "tAll": MessageLookupByLibrary.simpleMessage("All"),
        "tBackButton": MessageLookupByLibrary.simpleMessage("Back button"),
        "tCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "tCancelButton": MessageLookupByLibrary.simpleMessage("Cancel button"),
        "tDark": MessageLookupByLibrary.simpleMessage("Dark"),
        "tDeleteAllSelectedNotes": m0,
        "tDeleteNote": MessageLookupByLibrary.simpleMessage("Delete note"),
        "tDeleteNoteButton":
            MessageLookupByLibrary.simpleMessage("Delete note button"),
        "tDeleteNotes": MessageLookupByLibrary.simpleMessage("Delete notes"),
        "tDeleteThisNote":
            MessageLookupByLibrary.simpleMessage("¿Delete this note?"),
        "tEdit": MessageLookupByLibrary.simpleMessage("Edit"),
        "tEnterAText": MessageLookupByLibrary.simpleMessage("Enter a text"),
        "tEnterText": MessageLookupByLibrary.simpleMessage("Enter text"),
        "tFolders": MessageLookupByLibrary.simpleMessage("Folders"),
        "tItHasUpdated": MessageLookupByLibrary.simpleMessage("It has updated"),
        "tLanguage": MessageLookupByLibrary.simpleMessage("Language"),
        "tLanguageEnglish": MessageLookupByLibrary.simpleMessage("English"),
        "tLanguageSpanish": MessageLookupByLibrary.simpleMessage("Spanish"),
        "tLight": MessageLookupByLibrary.simpleMessage("Light"),
        "tMoveTo": MessageLookupByLibrary.simpleMessage("Move to"),
        "tMyNotes": MessageLookupByLibrary.simpleMessage("My Notes"),
        "tNameInUse": MessageLookupByLibrary.simpleMessage(
            "Oops! That name is already in use."),
        "tNewFolder": MessageLookupByLibrary.simpleMessage("New folder"),
        "tNoNote": MessageLookupByLibrary.simpleMessage("No notes yet"),
        "tNoTitle": MessageLookupByLibrary.simpleMessage("No Title"),
        "tNothingToSave":
            MessageLookupByLibrary.simpleMessage("Nothing to save"),
        "tOthers": MessageLookupByLibrary.simpleMessage("Others"),
        "tPrivacyPolicy":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "tRemove": MessageLookupByLibrary.simpleMessage("Remove"),
        "tRenameFolder": MessageLookupByLibrary.simpleMessage("Rename folder"),
        "tSaveNoteButton":
            MessageLookupByLibrary.simpleMessage("Save note button"),
        "tSearchNote": MessageLookupByLibrary.simpleMessage("Search note"),
        "tSelectFolder": MessageLookupByLibrary.simpleMessage("Select folder"),
        "tSelectedItem": m1,
        "tSetting": MessageLookupByLibrary.simpleMessage("Settings"),
        "tSettingButton":
            MessageLookupByLibrary.simpleMessage("Setting button"),
        "tShowLanguageMenu":
            MessageLookupByLibrary.simpleMessage("Show language menu"),
        "tShowThemeMenu":
            MessageLookupByLibrary.simpleMessage("Show theme menu"),
        "tStartwriting":
            MessageLookupByLibrary.simpleMessage("Empiece a escribir"),
        "tTheme": MessageLookupByLibrary.simpleMessage("Theme"),
        "tTitle": MessageLookupByLibrary.simpleMessage("Title"),
        "tWithoutCategory":
            MessageLookupByLibrary.simpleMessage("Without category"),
        "tWriteANote": MessageLookupByLibrary.simpleMessage("Escriba una nota")
      };
}
