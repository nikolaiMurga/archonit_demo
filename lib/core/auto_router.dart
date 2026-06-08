import 'package:auto_route/auto_route.dart';

import '../presentation/favorites/favorites_screen.dart';
import '../presentation/home/home_page.dart';

part 'auto_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: HomeRoute.page, initial: true),
        AutoRoute(path: '/favorites', page: FavoritesRoute.page),
      ];
}
