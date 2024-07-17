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
          transitionsBuilder: TransitionsBuilders.zoomIn,
          durationInMilliseconds: 400,
        ),
        CustomRoute(
          page: AddNoteRoute.page,
          path: RouteName.addNote,
          transitionsBuilder: TransitionsBuilders.slideBottom,
          durationInMilliseconds: 400,
        ),
        CustomRoute(
          page: UpdateNoteRoute.page,
          path: RouteName.updateNote,
          // TransitionsBuilders class contains a preset of common transitions builders.
          transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
          durationInMilliseconds: 400,
        ),
      ];
}

// Configuración de AutoRoute para utilizar la clave global
// final GlobalKey navigatorKey = GlobalKey();
