import 'package:app_creaty_mobile/ui/home/view/home_page.dart';
import 'package:app_creaty_mobile/ui/start_page.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const routePathStartupPage = '/';
  static const routePathHomePage = '/home';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: routePathStartupPage,
        builder: (context, state) {
          return StartPage(
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: routePathHomePage,
        builder: (context, state) {
          return HomePage(
            key: state.pageKey,
          );
        },
      ),
    ],
    debugLogDiagnostics: true,
  );
}
