import 'package:driveaustralia/features/Dashboard/navigation_board.dart';
import 'package:driveaustralia/features/ReadQuestionAnswer/question_answer_page.dart';
import 'package:driveaustralia/features/Splash/splash_page.dart';
import 'package:driveaustralia/features/Test/test_page.dart';
import 'package:driveaustralia/features/about/about_page.dart';
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
    GoRoute(
      path: '/aboutdeveloper',
      builder: (context, state) => const AboutDeveloperPage(),
    ),
    GoRoute(
      path: '/testpage/:id/:category/:lastPath',
      name: 'testpage',
      builder: (context, state) => TestPage(
        id: state.params['id'],
        category: state.params['category'],
        lastPath: state.params['lastPath'] ?? '',
      ),
    ),
    GoRoute(
      path: '/questionanswer/:id/:category/:lastPath',
      name: 'questionsanswer',
      builder: (context, state) => QuestionAnswerPage(
        id: state.params['id'],
        category: state.params['category'],
        lastPath: state.params['lastPath'] ?? '',
      ),
    ),
  ],
  // errorBuilder: (BuildContext context, GoRouterState state) =>
  //     const NotFoundPage(),
  // errorPageBuilder: (BuildContext context, GoRouterState state) =>
  //     const MaterialPage(child: NotFoundPage()),
);
