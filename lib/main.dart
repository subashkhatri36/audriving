import 'package:driveaustralia/bloc/dkt_bloc.dart';
import 'package:driveaustralia/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const Dktapp());
  });
}

class Dktapp extends StatelessWidget {
  const Dktapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DktBloc>(
          create: (BuildContext context) => DktBloc(
            DrivingState(),
          ),
        ),
      ],
      child: MaterialApp.router(
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
