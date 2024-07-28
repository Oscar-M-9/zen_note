import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_notes/app/config/router/router_name.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/presenter/providers/selected_note_provider.dart';
import 'package:my_notes/generated/l10n.dart';

class FloatAddNoteButton extends ConsumerWidget {
  const FloatAddNoteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Focus(
      child: Semantics(
        label: S.of(context).tAddNoteButton,
        excludeSemantics: true,
        focusable: true,
        button: true,
        expanded: false,
        child: FloatingActionButton(
          onPressed: () {
            ref.read(selectedNotesProvider.notifier).clear();
            context.router.pushNamed(RouteName.addNote);
          },
          elevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
          backgroundColor: ColorsApp.primary,
          child: Semantics(
            child: SvgPicture.asset(
              "assets/svg/add-note.svg",
              // color: Theme.of(context).appBarTheme.iconTheme?.color,
              // ignore: deprecated_member_use
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
