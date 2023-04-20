import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:driveaustralia/widgets/button_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NavigationBoard extends StatefulWidget {
  const NavigationBoard({Key? key}) : super(key: key);

  @override
  State<NavigationBoard> createState() => _NavigationBoardState();
}

class _NavigationBoardState extends State<NavigationBoard> {
  @override
  void initState() {
    context.read<DktBloc>().add(RefreshEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DktBloc>().state;

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(children: [
          //Here is banner ads
          // const AdmobBannerAdWidget(),
          // if (state.menu != null)
          Expanded(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              children: List.generate(state.menu?.length ?? 0, (index) {
                return InkWell(
                  onTap: () {
                    //this is most effective way
                    //pass parameter and Id
                    var id = state.menu?[index].id ?? '';
                    var category = state.menu?[index].menu ?? '';

                    if (id == 8) {
                      GoRouter.of(context).go(
                        context.namedLocation(
                          'aboutdeveloper',
                          params: {
                            'id': id.toString(),
                            'category': category,
                            'lastPath': GoRouterState.of(context).location,
                          },
                        ),
                      );
                    } else {
                      GoRouter.of(context).go(
                        context.namedLocation(
                          'questionsanswer',
                          params: {
                            'id': id.toString(),
                            'category': category,
                            'lastPath': GoRouterState.of(context).location,
                          },
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          state.menu?[index].icon ?? '',
                          height: MediaQuery.of(context).size.height * 0.05,
                          fit: BoxFit.fitHeight,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          state.menu?[index].menu ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          buttonMenu(
            context: context,
            id: 0,
            category: 'all',
            lastPath: GoRouterState.of(context).location,
          ),
        ]),
      ),
    );
  }
}
