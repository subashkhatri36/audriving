import 'package:driveaustralia/widgets/DrivingPage.dart';
import 'package:driveaustralia/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AboutDeveloperPage extends StatefulWidget {
  final String? category;
  final String? id;
  final String? lastPath;

  const AboutDeveloperPage({
    Key? key,
    this.category,
    this.lastPath,
    this.id,
  }) : super(key: key);

  @override
  State<AboutDeveloperPage> createState() => _AboutDeveloperPageState();
}

class _AboutDeveloperPageState extends State<AboutDeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return DrivingPage(
      lastpath: widget.lastPath ?? '',
      appBar: appBarBackButton(
        context,
        widget.category ?? '',
        widget.lastPath ?? '',
      ),
      body: Container(),
    );
  }
}
