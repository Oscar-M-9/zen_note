// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `My Notes`
  String get tMyNotes {
    return Intl.message(
      'My Notes',
      name: 'tMyNotes',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get tLanguageSpanish {
    return Intl.message(
      'Spanish',
      name: 'tLanguageSpanish',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get tLanguageEnglish {
    return Intl.message(
      'English',
      name: 'tLanguageEnglish',
      desc: '',
      args: [],
    );
  }

  /// `No notes yet`
  String get tNoNote {
    return Intl.message(
      'No notes yet',
      name: 'tNoNote',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get tSetting {
    return Intl.message(
      'Settings',
      name: 'tSetting',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get tDark {
    return Intl.message(
      'Dark',
      name: 'tDark',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get tLight {
    return Intl.message(
      'Light',
      name: 'tLight',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get tTheme {
    return Intl.message(
      'Theme',
      name: 'tTheme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get tLanguage {
    return Intl.message(
      'Language',
      name: 'tLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Delete note`
  String get tDeleteNote {
    return Intl.message(
      'Delete note',
      name: 'tDeleteNote',
      desc: '',
      args: [],
    );
  }

  /// `Delete notes`
  String get tDeleteNotes {
    return Intl.message(
      'Delete notes',
      name: 'tDeleteNotes',
      desc: '',
      args: [],
    );
  }

  /// `¿Delete this note?`
  String get tDeleteThisNote {
    return Intl.message(
      '¿Delete this note?',
      name: 'tDeleteThisNote',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get tCancel {
    return Intl.message(
      'Cancel',
      name: 'tCancel',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get tRemove {
    return Intl.message(
      'Remove',
      name: 'tRemove',
      desc: '',
      args: [],
    );
  }

  /// `It has updated`
  String get tItHasUpdated {
    return Intl.message(
      'It has updated',
      name: 'tItHasUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to save`
  String get tNothingToSave {
    return Intl.message(
      'Nothing to save',
      name: 'tNothingToSave',
      desc: '',
      args: [],
    );
  }

  /// `Search note`
  String get tSearchNote {
    return Intl.message(
      'Search note',
      name: 'tSearchNote',
      desc: '',
      args: [],
    );
  }

  /// `Back button`
  String get tBackButton {
    return Intl.message(
      'Back button',
      name: 'tBackButton',
      desc: '',
      args: [],
    );
  }

  /// `Setting button`
  String get tSettingButton {
    return Intl.message(
      'Setting button',
      name: 'tSettingButton',
      desc: '',
      args: [],
    );
  }

  /// `Add note button`
  String get tAddNoteButton {
    return Intl.message(
      'Add note button',
      name: 'tAddNoteButton',
      desc: '',
      args: [],
    );
  }

  /// `Save note button`
  String get tSaveNoteButton {
    return Intl.message(
      'Save note button',
      name: 'tSaveNoteButton',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get tTitle {
    return Intl.message(
      'Title',
      name: 'tTitle',
      desc: '',
      args: [],
    );
  }

  /// `Empiece a escribir`
  String get tStartwriting {
    return Intl.message(
      'Empiece a escribir',
      name: 'tStartwriting',
      desc: '',
      args: [],
    );
  }

  /// `Agregue un título`
  String get tAddATitle {
    return Intl.message(
      'Agregue un título',
      name: 'tAddATitle',
      desc: '',
      args: [],
    );
  }

  /// `Escriba una nota`
  String get tWriteANote {
    return Intl.message(
      'Escriba una nota',
      name: 'tWriteANote',
      desc: '',
      args: [],
    );
  }

  /// `Delete note button`
  String get tDeleteNoteButton {
    return Intl.message(
      'Delete note button',
      name: 'tDeleteNoteButton',
      desc: '',
      args: [],
    );
  }

  /// `Show language menu`
  String get tShowLanguageMenu {
    return Intl.message(
      'Show language menu',
      name: 'tShowLanguageMenu',
      desc: '',
      args: [],
    );
  }

  /// `Show theme menu`
  String get tShowThemeMenu {
    return Intl.message(
      'Show theme menu',
      name: 'tShowThemeMenu',
      desc: '',
      args: [],
    );
  }

  /// `Cancel button`
  String get tCancelButton {
    return Intl.message(
      'Cancel button',
      name: 'tCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get tOthers {
    return Intl.message(
      'Others',
      name: 'tOthers',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get tPrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'tPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `No Title`
  String get tNoTitle {
    return Intl.message(
      'No Title',
      name: 'tNoTitle',
      desc: '',
      args: [],
    );
  }

  /// `selected{s} item{s}`
  String tSelectedItem(Object s) {
    return Intl.message(
      'selected$s item$s',
      name: 'tSelectedItem',
      desc: '',
      args: [s],
    );
  }

  /// `¿Delete all selected notes ({value})?`
  String tDeleteAllSelectedNotes(Object value) {
    return Intl.message(
      '¿Delete all selected notes ($value)?',
      name: 'tDeleteAllSelectedNotes',
      desc: '',
      args: [value],
    );
  }

  /// `Move to`
  String get tMoveTo {
    return Intl.message(
      'Move to',
      name: 'tMoveTo',
      desc: '',
      args: [],
    );
  }

  /// `Folders`
  String get tFolders {
    return Intl.message(
      'Folders',
      name: 'tFolders',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get tAll {
    return Intl.message(
      'All',
      name: 'tAll',
      desc: '',
      args: [],
    );
  }

  /// `New folder`
  String get tNewFolder {
    return Intl.message(
      'New folder',
      name: 'tNewFolder',
      desc: '',
      args: [],
    );
  }

  /// `Enter text`
  String get tEnterText {
    return Intl.message(
      'Enter text',
      name: 'tEnterText',
      desc: '',
      args: [],
    );
  }

  /// `Enter a text`
  String get tEnterAText {
    return Intl.message(
      'Enter a text',
      name: 'tEnterAText',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get tAccept {
    return Intl.message(
      'Accept',
      name: 'tAccept',
      desc: '',
      args: [],
    );
  }

  /// `Oops! That name is already in use.`
  String get tNameInUse {
    return Intl.message(
      'Oops! That name is already in use.',
      name: 'tNameInUse',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get tEdit {
    return Intl.message(
      'Edit',
      name: 'tEdit',
      desc: '',
      args: [],
    );
  }

  /// `Rename folder`
  String get tRenameFolder {
    return Intl.message(
      'Rename folder',
      name: 'tRenameFolder',
      desc: '',
      args: [],
    );
  }

  /// `Without category`
  String get tWithoutCategory {
    return Intl.message(
      'Without category',
      name: 'tWithoutCategory',
      desc: '',
      args: [],
    );
  }

  /// `Select folder`
  String get tSelectFolder {
    return Intl.message(
      'Select folder',
      name: 'tSelectFolder',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
