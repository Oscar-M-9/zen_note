import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/presenter/providers/language_state_provider.dart';
import 'package:my_notes/generated/l10n.dart';

class ListTitleLanguage extends ConsumerWidget {
  const ListTitleLanguage({
    super.key,
    required this.languageSubtitle,
    required this.currentLanguage,
  });

  final String languageSubtitle;
  final LanguageApp currentLanguage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: SvgPicture.asset(
        "assets/svg/language.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).appBarTheme.iconTheme?.color,
      ),
      title: Text(
        S.of(context).tLanguage,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        languageSubtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: PopupMenuButton<LanguageApp>(
        icon: Semantics(
          label: S.of(context).tShowLanguageMenu,
          excludeSemantics: true,
          focusable: true,
          child: RotatedBox(
            quarterTurns: 75,
            child: SvgPicture.asset(
              "assets/svg/code.svg",
              // ignore: deprecated_member_use
              color: Theme.of(context).appBarTheme.iconTheme?.color,
            ),
          ),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: LanguageApp.spanish,
            child: ListTile(
              title: Text(
                S.of(context).tLanguageSpanish,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: currentLanguage == LanguageApp.spanish
                  ? SizedBox(
                      width: 20,
                      child: SvgPicture.asset(
                        "assets/svg/check-circle.svg",
                        // ignore: deprecated_member_use
                        color: ColorsApp.primary,
                      ),
                    )
                  : null,
            ),
          ),
          PopupMenuItem(
            value: LanguageApp.english,
            child: ListTile(
              title: Text(
                S.of(context).tLanguageEnglish,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: currentLanguage == LanguageApp.english
                  ? SizedBox(
                      width: 20,
                      child: SvgPicture.asset(
                        "assets/svg/check-circle.svg",
                        // ignore: deprecated_member_use
                        color: ColorsApp.primary,
                      ),
                    )
                  : null,
            ),
          ),
        ],
        onSelected: (language) {
          ref.read(languageProvider.notifier).setLanguage(language);
        },
      ),
    );
  }
}
