import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrivingPage extends StatefulWidget {
  const DrivingPage({
    Key? key,
    this.body,
    this.appBar,
    required this.lastpath,
  }) : super(key: key);
  final Widget? body;
  final AppBar? appBar;
  final String lastpath;

  @override
  State<DrivingPage> createState() => _DrivingPageState();
}

class _DrivingPageState extends State<DrivingPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go(widget.lastpath);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.appBar,
        body: SafeArea(child: widget.body ?? Container()),
      ),
    );
  }
}
