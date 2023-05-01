import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:driveaustralia/route/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await MobileAds.instance.initialize();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
        .then((_) {
      runApp(const Dktapp());
    });
  } else {
    const Dktapp();
  }
}

class Dktapp extends StatelessWidget {
  const Dktapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('This is app');
    return MultiBlocProvider(
      providers: [
        BlocProvider<DktBloc>(
          create: (BuildContext context) =>
              DktBloc(
                DrivingState(),
              ),
        ),
      ],
      child: kIsWeb
          ? MaterialApp(
        title: 'Australia Driving Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashWeb(),

        builder: FToastBuilder(),
      )
          : MaterialApp.router(
        title: 'Australia Driving Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        builder: FToastBuilder(),
      ),
    );
  }
}

class SplashWeb extends StatelessWidget {
  const SplashWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('This is web Version'),
    );
  }
}
