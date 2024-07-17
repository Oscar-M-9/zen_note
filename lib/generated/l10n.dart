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
