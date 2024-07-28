import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/presenter/providers/theme_state_provider.dart';
import 'package:my_notes/generated/l10n.dart';

class ListTitleTheme extends ConsumerWidget {
  const ListTitleTheme({
    super.key,
    required this.themeSubtitle,
    required this.currentTheme,
  });

  final String themeSubtitle;
  final ThemeApp currentTheme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: SvgPicture.asset(
        "assets/svg/appearance.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).appBarTheme.iconTheme?.color,
      ),
      title: Text(
        S.of(context).tTheme,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        themeSubtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: PopupMenuButton<ThemeApp>(
        icon: RotatedBox(
          quarterTurns: 75,
          child: Semantics(
            label: S.of(context).tShowThemeMenu,
            excludeSemantics: true,
            focusable: true,
            child: SvgPicture.asset(
              "assets/svg/code.svg",
              // ignore: deprecated_member_use
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: ThemeApp.light,
            child: ListTile(
              title: Text(
                S.of(context).tLight,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: currentTheme == ThemeApp.light
                  ? SvgPicture.asset(
                      "assets/svg/check-circle.svg",
                      // ignore: deprecated_member_use
                      color: ColorsApp.primary,
                    )
                  : null,
            ),
          ),
          PopupMenuItem(
            value: ThemeApp.dark,
            child: ListTile(
              title: Text(
                S.of(context).tDark,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: currentTheme == ThemeApp.dark
                  ? SvgPicture.asset(
                      "assets/svg/check-circle.svg",
                      // ignore: deprecated_member_use
                      color: ColorsApp.primary,
                    )
                  : null,
            ),
          ),
          // PopupMenuItem(
          //   value: ThemeApp.system,
          //   child: ListTile(
          //     title: const Text('Tema del Sistema'),
          //     trailing: currentTheme == ThemeApp.system
          //         ? const Icon(Icons.check, color: Colors.blue)
          //         : null,
          //   ),
          // ),
        ],
        onSelected: (theme) {
          ref.read(themeProvider.notifier).setTheme(theme);
        },
      ),
    );
  }
}
