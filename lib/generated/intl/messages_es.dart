// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static String m0(value) =>
      "¿Eliminar todas las notas seleccionadas (${value})?";

  static String m1(s) => "elemento${s} seleccionado${s}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "tAccept": MessageLookupByLibrary.simpleMessage("Aceptar"),
        "tAddATitle": MessageLookupByLibrary.simpleMessage("agregue un título"),
        "tAddNoteButton":
            MessageLookupByLibrary.simpleMessage("Botón de agregar nota"),
        "tAll": MessageLookupByLibrary.simpleMessage("Todo"),
        "tBackButton": MessageLookupByLibrary.simpleMessage("Botón atras"),
        "tCancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "tCancelButton":
            MessageLookupByLibrary.simpleMessage("Botón de cancelar"),
        "tDark": MessageLookupByLibrary.simpleMessage("Oscuro"),
        "tDeleteAllSelectedNotes": m0,
        "tDeleteNote": MessageLookupByLibrary.simpleMessage("Eliminar nota"),
        "tDeleteNoteButton":
            MessageLookupByLibrary.simpleMessage("Botón de eliminar nota"),
        "tDeleteNotes": MessageLookupByLibrary.simpleMessage("Eliminar notas"),
        "tDeleteThisNote":
            MessageLookupByLibrary.simpleMessage("¿Eliminar esta nota?"),
        "tEdit": MessageLookupByLibrary.simpleMessage("Editar"),
        "tEnterAText": MessageLookupByLibrary.simpleMessage("Ingrese un texto"),
        "tEnterText": MessageLookupByLibrary.simpleMessage("Introducir texto"),
        "tFolders": MessageLookupByLibrary.simpleMessage("Carpetas"),
        "tItHasUpdated": MessageLookupByLibrary.simpleMessage("Se actualizó"),
        "tLanguage": MessageLookupByLibrary.simpleMessage("Idioma"),
        "tLanguageEnglish": MessageLookupByLibrary.simpleMessage("Ingles"),
        "tLanguageSpanish": MessageLookupByLibrary.simpleMessage("Español"),
        "tLight": MessageLookupByLibrary.simpleMessage("Claro"),
        "tMoveTo": MessageLookupByLibrary.simpleMessage("Mover a"),
        "tMyNotes": MessageLookupByLibrary.simpleMessage("Mis Notas"),
        "tNameInUse": MessageLookupByLibrary.simpleMessage(
            "¡Ups! Ese nombre ya está en uso."),
        "tNewFolder": MessageLookupByLibrary.simpleMessage("Nueva carpeta"),
        "tNoNote": MessageLookupByLibrary.simpleMessage("Aún no hay notas"),
        "tNoTitle": MessageLookupByLibrary.simpleMessage("Sin título"),
        "tNothingToSave":
            MessageLookupByLibrary.simpleMessage("Nada que guardar"),
        "tOthers": MessageLookupByLibrary.simpleMessage("Otros"),
        "tPrivacyPolicy":
            MessageLookupByLibrary.simpleMessage("Política de Privacidad"),
        "tRemove": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "tRenameFolder":
            MessageLookupByLibrary.simpleMessage("Renombrar carpeta"),
        "tSaveNoteButton":
            MessageLookupByLibrary.simpleMessage("Botón de guardar nota"),
        "tSearchNote": MessageLookupByLibrary.simpleMessage("Buscar nota"),
        "tSelectFolder":
            MessageLookupByLibrary.simpleMessage("Seleccionar carpeta"),
        "tSelectedItem": m1,
        "tSetting": MessageLookupByLibrary.simpleMessage("Configuración"),
        "tSettingButton":
            MessageLookupByLibrary.simpleMessage("Botón de configuración"),
        "tShowLanguageMenu":
            MessageLookupByLibrary.simpleMessage("Mostar menu de idiomas"),
        "tShowThemeMenu":
            MessageLookupByLibrary.simpleMessage("Mostrar menu de temas"),
        "tTheme": MessageLookupByLibrary.simpleMessage("Tema"),
        "tTitle": MessageLookupByLibrary.simpleMessage("Título"),
        "tWithoutCategory":
            MessageLookupByLibrary.simpleMessage("Sin categoría"),
        "tWriteANote": MessageLookupByLibrary.simpleMessage("Escribe una nota")
      };
}
