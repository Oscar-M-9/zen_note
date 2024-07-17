import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:my_notes/app/config/theme/colors_app.dart';
import 'package:my_notes/app/presenter/controllers/hive_manager.dart';
import 'package:my_notes/generated/l10n.dart';
import 'package:my_notes/app/config/router/router.dart';

import 'package:my_notes/app/presenter/providers/language_state_provider.dart';
import 'package:my_notes/app/presenter/providers/theme_state_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  await HiveManager.init();
  runApp(
    const ProviderScope(
      child: KeyboardVisibilityProvider(
        child: MainApp(),
      ),
    ),
  );
}

final _appRouter = AppRouter();

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeDataProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      // key: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "My Notes",
      color: ColorsApp.primary,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale,
      theme: themeData,
      themeAnimationCurve: Curves.bounceIn,
      routerConfig: _appRouter.config(),
    );
  }
}
