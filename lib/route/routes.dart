import 'package:driveaustralia/features/Dashboard/navigation_board.dart';
import 'package:driveaustralia/features/Splash/splash_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/navigation',
      builder: (context, state) => const NavigationBoard(),
    ),
  ],
);
