import 'package:fluro/fluro.dart';

class AppRouter {
  static FluroRouter router = FluroRouter.appRouter;

  final List<AppRoute> _routes;
  final Handler _notFoundHandler;

  List<AppRoute> get routes => _routes;

  const AppRouter({
    List<AppRoute> routes,
    Handler notFoundHandler,
  })  : _routes = routes,
        _notFoundHandler = notFoundHandler;

  void setupRoutes() {
    router.notFoundHandler = _notFoundHandler;
    routes.forEach(
      (AppRoute route) => router.define(route.route, handler: route.handler),
    );
  }
}
