import 'package:archonit_demo/presentation/favorites/favorites_screen.dart';
import 'package:archonit_demo/presentation/home/home_page.dart';
import 'package:auto_route/auto_route.dart';

part 'auto_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: HomeRoute.page, initial: true),
    AutoRoute(path: '/favorites', page: FavoritesRoute.page),
  ];
}
