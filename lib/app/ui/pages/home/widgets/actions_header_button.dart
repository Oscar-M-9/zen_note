import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auto_route/auto_route.dart';

import 'package:my_notes/app/config/router/router_name.dart';
import 'package:my_notes/app/presenter/providers/selected_note_provider.dart';
import 'package:my_notes/generated/l10n.dart';

class ActionsHeaderButton extends ConsumerWidget {
  const ActionsHeaderButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNotes = ref.watch(selectedNotesProvider);
    return Positioned(
      top: 35,
      right: 10,
      child: selectedNotes.isEmpty
          ? Row(
              children: [
                Semantics(
                  label: S.of(context).tSettingButton,
                  excludeSemantics: true,
                  focusable: true,
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      ref.read(selectedNotesProvider.notifier).clear();
                      context.router.pushNamed(RouteName.categoryFolder);
                    },
                    icon: SvgPicture.asset(
                      "assets/svg/folder-with-files.svg",
                      // ignore: deprecated_member_use
                      color: Theme.of(context).appBarTheme.iconTheme?.color,
                      width: 20,
                    ),
                  ),
                ),
                Semantics(
                  label: S.of(context).tSettingButton,
                  excludeSemantics: true,
                  focusable: true,
                  child: IconButton(
                    onPressed: () {
                      ref.read(selectedNotesProvider.notifier).clear();
                      context.router.pushNamed(RouteName.setting);
                    },
                    icon: SvgPicture.asset(
                      "assets/svg/settings.svg",
                      // ignore: deprecated_member_use
                      color: Theme.of(context).appBarTheme.iconTheme?.color,
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
