import 'package:auto_route/auto_route.dart';
import 'package:my_notes/app/config/router/router.gr.dart';
import 'package:my_notes/app/config/router/router_name.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  //RouteType  -->  .material() .cupertino, .adaptive ..etc
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(
          page: HomeRoute.page,
          path: RouteName.home,
          initial: true,
        ),
        CustomRoute(
          page: SettingRoute.page,
          path: RouteName.setting,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 250,
        ),
        CustomRoute(
          page: AddNoteRoute.page,
          path: RouteName.addNote,
          transitionsBuilder: TransitionsBuilders.slideBottom,
          durationInMilliseconds: 250,
        ),
        CustomRoute(
          page: UpdateNoteRoute.page,
          path: RouteName.updateNote,
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 250,
        ),
        CustomRoute(
          page: CategoryFolderRoute.page,
          path: RouteName.categoryFolder,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 250,
        ),
        CustomRoute(
          page: MoveToNoteRoute.page,
          path: RouteName.moveToNote,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 250,
        ),
      ];
}

// Configuración de AutoRoute para utilizar la clave global
// final GlobalKey navigatorKey = GlobalKey();
