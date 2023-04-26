import 'package:driveaustralia/features/Dashboard/navigation_board.dart';
import 'package:driveaustralia/features/ReadQuestionAnswer/question_answer_page.dart';
import 'package:driveaustralia/features/Splash/splash_page.dart';
import 'package:driveaustralia/features/Test/test_page.dart';
import 'package:driveaustralia/features/about/about_page.dart';
import 'package:driveaustralia/features/result/result_page.dart';
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
      path: '/aboutdeveloper/:id/:category/:lastPath',
      name: 'aboutdeveloper',
      builder: (context, state) => AboutDeveloperPage(
        id: state.params['id'],
        category: state.params['category'],
        lastPath: state.params['lastPath'] ?? '',
      ),
    ),
    GoRoute(
      path: '/testpage/:id/:category/:lastPath/:isTest/:isPractiseOrTest',
      name: 'testpage',
      builder: (context, state) => TestPage(
        id: state.params['id'] ?? '0',
        category: state.params['category'] ?? '',
        lastPath: state.params['lastPath'] ?? '',
        isTest: state.params['isTest'] ?? '0',
        isPractiseOrTest: state.params['isPractiseOrTest'] ?? '0',
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
    GoRoute(
      path: '/showresult/:lastPath',
      name: 'showresult',
      builder: (context, state) => ResultPage(
        lastPath: state.params['lastPath'] ?? '',
      ),
    ),
  ],
  // errorBuilder: (BuildContext context, GoRouterState state) =>
  //     const NotFoundPage(),
  // errorPageBuilder: (BuildContext context, GoRouterState state) =>
  //     const MaterialPage(child: NotFoundPage()),
);
