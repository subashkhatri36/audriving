import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBoard extends StatefulWidget {
  const NavigationBoard({Key? key}) : super(key: key);

  @override
  State<NavigationBoard> createState() => _NavigationBoardState();
}

class _NavigationBoardState extends State<NavigationBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is Navigation Page.'),
      ),
    );
  }
}
