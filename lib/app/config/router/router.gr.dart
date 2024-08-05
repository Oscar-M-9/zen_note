// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:my_notes/app/infra/models/note_model.dart' as _i9;
import 'package:my_notes/app/ui/pages/add_note/add_note.dart' as _i1;
import 'package:my_notes/app/ui/pages/category_folder/category_folder_page.dart'
    as _i2;
import 'package:my_notes/app/ui/pages/category_folder/move_to/move_to_page.dart'
    as _i4;
import 'package:my_notes/app/ui/pages/home/home_page.dart' as _i3;
import 'package:my_notes/app/ui/pages/setting_page/setting_page.dart' as _i5;
import 'package:my_notes/app/ui/pages/update_note/update_note.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AddNoteRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddNotePage(),
      );
    },
    CategoryFolderRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CategoryFolderPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePage(),
      );
    },
    MoveToNoteRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.MoveToNotePage(),
      );
    },
    SettingRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SettingPage(),
      );
    },
    UpdateNoteRoute.name: (routeData) {
      final args = routeData.argsAs<UpdateNoteRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.UpdateNotePage(
          key: args.key,
          note: args.note,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AddNotePage]
class AddNoteRoute extends _i7.PageRouteInfo<void> {
  const AddNoteRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AddNoteRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddNoteRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.CategoryFolderPage]
class CategoryFolderRoute extends _i7.PageRouteInfo<void> {
  const CategoryFolderRoute({List<_i7.PageRouteInfo>? children})
      : super(
          CategoryFolderRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryFolderRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.MoveToNotePage]
class MoveToNoteRoute extends _i7.PageRouteInfo<void> {
  const MoveToNoteRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MoveToNoteRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoveToNoteRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SettingPage]
class SettingRoute extends _i7.PageRouteInfo<void> {
  const SettingRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.UpdateNotePage]
class UpdateNoteRoute extends _i7.PageRouteInfo<UpdateNoteRouteArgs> {
  UpdateNoteRoute({
    _i8.Key? key,
    required _i9.Note note,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          UpdateNoteRoute.name,
          args: UpdateNoteRouteArgs(
            key: key,
            note: note,
          ),
          initialChildren: children,
        );

  static const String name = 'UpdateNoteRoute';

  static const _i7.PageInfo<UpdateNoteRouteArgs> page =
      _i7.PageInfo<UpdateNoteRouteArgs>(name);
}

class UpdateNoteRouteArgs {
  const UpdateNoteRouteArgs({
    this.key,
    required this.note,
  });

  final _i8.Key? key;

  final _i9.Note note;

  @override
  String toString() {
    return 'UpdateNoteRouteArgs{key: $key, note: $note}';
  }
}
