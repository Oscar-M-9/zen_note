import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/presenter/providers/language_state_provider.dart';
import 'package:my_notes/app/presenter/providers/theme_state_provider.dart';
import 'package:my_notes/app/ui/shared/custom_back_button.dart';
import 'package:my_notes/generated/l10n.dart';

@RoutePage()
class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final currentLanguage = ref.watch(languageProvider);

    String themeSubtitle = '';
    String languageSubtitle = '';

    switch (currentTheme) {
      case ThemeApp.light:
        themeSubtitle = S.of(context).tLight;
        break;
      case ThemeApp.dark:
        themeSubtitle = S.of(context).tDark;
        break;
      default:
        themeSubtitle = '';
    }

    switch (currentLanguage) {
      case LanguageApp.spanish:
        languageSubtitle = S.of(context).tLanguageSpanish;
        break;
      case LanguageApp.english:
        languageSubtitle = S.of(context).tLanguageEnglish;
        break;
      default:
        languageSubtitle = '';
    }

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(S.of(context).tSetting),
      ),
      body: Column(
        children: [
          // Theme
          ListTile(
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
                child: SvgPicture.asset(
                  "assets/svg/code.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
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
          ),
          // Language
          ListTile(
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
              icon: RotatedBox(
                quarterTurns: 75,
                child: SvgPicture.asset(
                  "assets/svg/code.svg",
                  // ignore: deprecated_member_use
                  color: Theme.of(context).appBarTheme.iconTheme?.color,
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
          ),
        ],
      ),
    );
  }
}
