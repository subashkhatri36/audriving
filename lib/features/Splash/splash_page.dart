import 'dart:async';

import 'package:driveaustralia/ads/ads_lifecycle.dart';
import 'package:driveaustralia/ads/ads_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driveaustralia/bloc/dkt_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  // AdmobController admobController=AdmobController();
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        context.replace('/navigation');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<DktBloc, DrivingState>(
      listener: (context, state) {},
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
  late AppLifecycleReactor _appLifecycleReactor;

  @override
  void initState() {
    // context.read<DktBloc>().add(FetchDktDataEvent());
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    _appLifecycleReactor =
        AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<DktBloc>().state;
    return Center(
      child: watch.models == null
          ? Text('Model is Empty')
          : Text('Model is not Empty'),
    );
  }
}
