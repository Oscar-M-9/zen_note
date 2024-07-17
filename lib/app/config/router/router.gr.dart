// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:my_notes/app/infra/models/note_model.dart' as _i7;
import 'package:my_notes/app/ui/pages/add_note.dart' as _i1;
import 'package:my_notes/app/ui/pages/home/home_page.dart' as _i2;
import 'package:my_notes/app/ui/pages/setting_page/setting_page.dart' as _i3;
import 'package:my_notes/app/ui/pages/update_note.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AddNoteRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddNotePage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SettingPage(),
      );
    },
    UpdateNoteRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateNoteRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.UpdateNotePage(
          key: args.key,
          note: args.note,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AddNotePage]
class AddNoteRoute extends _i5.PageRouteInfo<void> {
  const AddNoteRoute({List<_i5.PageRouteInfo>? children})
      : super(
          AddNoteRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddNoteRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SettingPage]
class SettingRoute extends _i5.PageRouteInfo<void> {
  const SettingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.UpdateNotePage]
class UpdateNoteRoute extends _i5.PageRouteInfo<UpdateNoteRouteArgs> {
  UpdateNoteRoute({
    _i6.Key? key,
    required _i7.Note note,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          UpdateNoteRoute.name,
          args: UpdateNoteRouteArgs(
            key: key,
            note: note,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateNoteRoute';

  static const _i5.PageInfo<UpdateNoteRouteArgs> page =
      _i5.PageInfo<UpdateNoteRouteArgs>(name);
}

class UpdateNoteRouteArgs {
  const UpdateNoteRouteArgs({
    this.key,
    required this.note,
  });

  final _i6.Key? key;

  final _i7.Note note;

  @override
  String toString() {
    return 'UpdateNoteRouteArgs{key: $key, note: $note}';
  }
}
