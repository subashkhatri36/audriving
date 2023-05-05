import 'dart:async';

import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('This is splash screen');
    return Scaffold(
        body: BlocListener<DktBloc, DrivingState>(
      listener: (context, state) {
        if (state.loadingvalue) {
          Timer(
            const Duration(seconds: 1),
            () {
              context.go('/navigation');
            },
          );
        }
      },
      child: const SplashWidget(),
    ));
  }
}

class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    context.read<DktBloc>().add(FetchDktDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<DktBloc>().state;

    return Center(
        child: Image.asset(
      'assets/dkt.png',
      width: MediaQuery.of(context).size.width * .8,
      fit: BoxFit.fitWidth,
    ));
  }
}
