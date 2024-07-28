import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:my_notes/app/presenter/providers/language_state_provider.dart';
import 'package:my_notes/app/presenter/providers/theme_state_provider.dart';
import 'package:my_notes/app/ui/pages/setting/widgets/list_title_language.dart';
import 'package:my_notes/app/ui/pages/setting/widgets/list_title_theme.dart';
import 'package:my_notes/app/ui/shared/custom_back_button.dart';
import 'package:my_notes/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

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

    final Uri toLaunch = Uri(
        scheme: 'https',
        host: 'oscar-m-9.github.io',
        path: 'privacy-policy/my-notes/privacy-policy-my-notes');

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(S.of(context).tSetting),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Theme
          ListTitleTheme(
            themeSubtitle: themeSubtitle,
            currentTheme: currentTheme,
          ),
          // Language
          ListTitleLanguage(
            languageSubtitle: languageSubtitle,
            currentLanguage: currentLanguage,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).tOthers,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              S.of(context).tPrivacyPolicy,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).appBarTheme.iconTheme?.color,
              size: 20,
            ),
            onTap: () async {
              if (await canLaunchUrl(toLaunch)) {
                await launchUrl(
                  toLaunch,
                  mode: LaunchMode.externalApplication,
                );
              } else {
                throw 'Could not launch $toLaunch';
              }
            },
          )
        ],
      ),
    );
  }
}
